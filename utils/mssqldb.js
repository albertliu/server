const mssql = require('mssql');

const config = {
  user: 'sqlrw',
  password: process.env.NODE_ENV_DB_PASSWD,
  server: process.env.NODE_ENV_DB,
  database: 'elearning',
  port: 14333,
  options: {
    encrypt: false
  },
  connectionTimeout: 15000,
  requestTimeout: 30000,
  pool: {
    min: 0,
    max: 50,
    idleTimeoutMillis: 30000
  }
};

const pool = new mssql.ConnectionPool(config);
const poolConnect = pool.connect();

pool.on('error', err => {
  console.error('SQL connection pool error:', err);
});

function isPlainObject(value) {
  return Object.prototype.toString.call(value) === '[object Object]';
}

function isExplicitParam(value) {
  return isPlainObject(value) && Object.prototype.hasOwnProperty.call(value, 'type');
}

function inferSqlType(value) {
  if (value === null || value === undefined) return mssql.NVarChar;

  if (typeof value === 'string') {
    return value.length > 4000
      ? mssql.NVarChar(mssql.MAX)
      : mssql.NVarChar(Math.max(value.length, 1));
  }

  if (typeof value === 'boolean') return mssql.Bit;
  if (typeof value === 'bigint') return mssql.BigInt;

  if (typeof value === 'number') {
    if (!Number.isFinite(value)) {
      throw new TypeError('Invalid SQL parameter: number must be finite.');
    }

    if (Number.isInteger(value)) {
      return value >= -2147483648 && value <= 2147483647
        ? mssql.Int
        : mssql.BigInt;
    }

    return mssql.Decimal(18, 6);
  }

  if (value instanceof Date) {
    if (Number.isNaN(value.getTime())) {
      throw new TypeError('Invalid SQL parameter: Date is invalid.');
    }

    return mssql.DateTime2;
  }

  if (Buffer.isBuffer(value)) return mssql.VarBinary(mssql.MAX);

  return mssql.NVarChar(mssql.MAX);
}

function normalizeParams(params) {
  if (params === null || params === undefined || params === '') return {};

  if (!isPlainObject(params)) {
    throw new TypeError('SQL parameters must be a plain object.');
  }

  return params;
}

function getParamType(param) {
  return isExplicitParam(param) ? param.type : inferSqlType(param);
}

function getParamValue(param) {
  return isExplicitParam(param) ? param.value : param;
}

function bindInputs(request, params) {
  for (const [name, param] of Object.entries(normalizeParams(params))) {
    if (!name || name.startsWith('@')) {
      throw new TypeError(`Invalid SQL parameter name: ${name}`);
    }

    request.input(name, getParamType(param), getParamValue(param) ?? null);
  }

  return request;
}

function toCallback(promise, callback) {
  if (typeof callback !== 'function') return promise;

  promise
    .then(result => callback(null, result))
    .catch(err => callback(err, null));

  return undefined;
}

async function executeSQLAsync(sql, params = {}) {
  if (typeof sql !== 'string' || sql.trim() === '') {
    throw new TypeError('SQL text must be a non-empty string.');
  }
  const startedAt = Date.now();

  try {
    const connectedPool = await poolConnect;
    const request = bindInputs(connectedPool.request(), params);
    return await request.query(sql);
  } finally {
    const elapsed = Date.now() - startedAt;
    if (elapsed > 1500) {
      console.warn('Slow SQL:', {
        elapsed,
        sql,
        params
      });
    }
  }
}

async function executeProcAsync(proc, params = {}) {
  if (typeof proc !== 'string' || proc.trim() === '') {
    throw new TypeError('Procedure name must be a non-empty string.');
  }
  const startedAt = Date.now();

  try {
    const connectedPool = await poolConnect;
    const request = bindInputs(connectedPool.request(), params);

    return request.execute(proc);
  } finally {
    const elapsed = Date.now() - startedAt;
    if (elapsed > 1500) {
      console.warn('Slow SQL:', {
        elapsed,
        proc,
        params
      });
    }
  }
}

function executeSQL(sql, params, callback) {
  return toCallback(executeSQLAsync(sql, params), callback);
}

function executeProc(proc, params, callback) {
  return toCallback(executeProcAsync(proc, params), callback);
}

async function close() {
  await pool.close();
}

module.exports = {
  config,
  mssql,
  pool,
  close,
  bindInputs,
  inferSqlType,

  executeSQL,
  executeProc,
  executeSQLAsync,
  executeProcAsync,

  // 兼容原来的拼写，避免现有代码立即报错。
  excuteSQL: executeSQL,
  excuteProc: executeProc,
  excuteProcAsync: executeProcAsync
};