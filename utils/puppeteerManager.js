const puppeteer = require('puppeteer');
// npm install puppeteer@25.10.0 --save-exact

const MAX_CONCURRENT_PAGES = 2;
let browserPromise = null;
let activePages = 0;
const waiters = [];

function acquireSlot() {
  if (activePages < MAX_CONCURRENT_PAGES) {
    activePages += 1;
    return Promise.resolve();
  }
  return new Promise(resolve => waiters.push(resolve));
}

function releaseSlot() {
  const next = waiters.shift();
  if (next) next();
  else activePages -= 1;
}

async function getBrowser() {
  if (!browserPromise) {
    browserPromise = puppeteer.launch({
      args: ['--disable-dev-shm-usage', '--no-sandbox', '--disable-pdf-tagging']
    }).then(browser => {
      browser.once('disconnected', () => { browserPromise = null; });
      return browser;
    }).catch(err => {
      browserPromise = null;
      throw err;
    });
  }
  return browserPromise;
}

async function withPage(task) {
  await acquireSlot();
  let page;
  try {
    const browser = await getBrowser();
    page = await browser.newPage();
    page.on('error', err => console.error('Puppeteer page crashed:', err));
    return await task(page);
  } finally {
    if (page && !page.isClosed()) {
      await page.close().catch(err => console.error('Failed to close Puppeteer page:', err));
    }
    releaseSlot();
  }
}

module.exports = { withPage };
