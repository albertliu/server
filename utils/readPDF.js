const fs = require("fs");
var db = require("../utils/mssqldb");
// 确保 pdf-parse 正确加载
let pdfParse;
try {
    pdfParse = require('pdf-parse');
    if (typeof pdfParse !== 'function') {
        pdfParse = pdfParse.default;
    }
} catch (e) {
    console.error('请先安装 pdf-parse: npm install pdf-parse@1.1.1');
    process.exit(1);
}
var response, sqlstr, params;
let count = 0;
let registerID = "";
let classID = "";

/**
 * 解析PDF文件，提取所有准考证信息
 * @param {string} filePath PDF文件路径
 * @returns {Array} 准考证对象数组，每个对象包含 name, idNumber, startTime, location
 */
async function parseTicketsFromPDF(filePath) {
    // 1. 检查文件是否存在
    if (!fs.existsSync(filePath)) {
        throw new Error(`文件不存在: ${filePath}`);
    }

    // 2. 读取文件并尝试解析
    const dataBuffer = fs.readFileSync(filePath);
    let text = '';
    try {
        const data = await pdfParse(dataBuffer);
        text = data.text || '';
    } catch (err) {
        throw new Error(`PDF 解析失败: ${err.message}`);
    }

    // 调试：保存原始文本
    // fs.writeFileSync('./debug.txt', text, 'utf-8');
    // console.log(`📝 原始文本已保存至 debug.txt，共 ${text.length} 个字符`);

    // 3. 检查是否为空文本
    if (text.trim().length === 0) {
        console.warn('⚠️  PDF 未提取到任何文本，可能为扫描件。建议使用 OCR 或检查 PDF 是否有文字层。');
        return []; // 返回空数组，后续不会存入数据库
    }

    // 按“姓名”分割每个准考证块
    const blocks = text.split(/(?=姓名[\u4e00-\u9fa5]+)/).filter(b => b.trim().length > 0);
    // console.log(`解析到 ${blocks.length} 个准考证块, ${filePath}`);
    const tickets = [];

    for (let block of blocks) {
        // 如果块中没有“姓名”，跳过
        if (!/姓名/.test(block)) continue;
        const ticket = {};

        // 1. 姓名（中文）
        const nameMatch = block.match(/姓名\s*([\u4e00-\u9fa5]+)/);
        if (nameMatch) ticket.name = nameMatch[1].trim();

        // 2. 证件号码（18位身份证，最后一位可能为X）
        const idMatch = block.match(/证件号码\s*(\d{17}[\dXx]?)/);
        if (idMatch) ticket.idNumber = idMatch[1].trim();

        // 3. 入场开始时间（格式：YYYY-MM-DD HH:MM）
        const timeMatch = block.match(/入场开始时间\s*(\d{4}-\d{2}-\d{2}\s*\d{2}:\d{2})/);
        if (timeMatch) ticket.startTime = timeMatch[1].trim();

        // 4. 考试地点（可能位于行末，使用行匹配或正则）
        let location = null;
        const lines = block.split('\n');
        for (let line of lines) {
            if (line.includes('考试地点')) {
                location = line.replace(/考试地点\s*/, '').trim();
                break;
            }
        }
        // 5. 考试类别
        const kindMatch = block.match(/考试类别\s*([^\n]+)/);
        if (kindMatch) ticket.kind = kindMatch[1].trim();
        // 6. 资格类型
        const certNameMatch = block.match(/资格类型\s*([^\n]+)/);
        if (certNameMatch) ticket.certName = certNameMatch[1].trim();
        // 7. 准考证号
        const examNoMatch = block.match(/准考证号\s*(\d+)/);
        if (examNoMatch) ticket.examNo = examNoMatch[1].trim();

        // 若未找到，使用全局正则（多行模式）
        if (!location) {
            const locMatch = block.match(/考试地点\s*(.+)$/m);
            if (locMatch) location = locMatch[1].trim();
        }
        ticket.location = location;

        // 仅当四个关键字段均存在时视为有效准考证
        if (ticket.name && ticket.idNumber && ticket.startTime && ticket.location) {
            tickets.push(ticket);
        } else {
            console.warn('跳过不完整的准考证块:', block.substring(0, 100));
        }
    }

    return tickets;
}

/**
 * 将准考证数据逐条调用存储过程 setExamInfo
 * @param {Array} tickets 准考证数组
 */
async function saveTicketsToDB(tickets) {
    try {
        for (const ticket of tickets) {
          let param = {
            name: ticket.name,
            username: ticket.idNumber,
            examDate: ticket.startTime,
            examAddress: ticket.location,
            certName: ticket.certName,
            kind: ticket.kind,
            examNo: ticket.examNo,
            batchID: classID,
            registerID: registerID
          };
        //   console.log("saveTicketsToDB param:", param);
          await db.executeProcAsync('generateApply2', param);
        }
        // console.log(`共成功存储 ${tickets.length} 条记录。`);
    } catch (err) {
        console.error('数据库操作失败:', err);
    }
}

async function readPDF(pdfPath, key, currUser) {
  registerID = currUser;
  classID = key;
    try {
        const tickets = await parseTicketsFromPDF(pdfPath);
        // console.log(`解析到 ${tickets.length} 张准考证`);
        if (tickets.length > 0) {
            await saveTicketsToDB(tickets);
            return tickets.length;
        }
    } catch (err) {
        console.error('处理失败:', err);
        return 0;
    }
}

module.exports = {
  readPDF
};