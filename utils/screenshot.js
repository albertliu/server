const puppeteerManager = require('./puppeteerManager');

async function autoScroll(page) {
  return page.evaluate(() => new Promise(resolve => {
    let totalHeight = 0;
    const distance = 100;
    const timer = setInterval(() => {
      const scrollHeight = document.body.scrollHeight;
      window.scrollBy(0, distance);
      totalHeight += distance;
      if (totalHeight >= scrollHeight) {
        clearInterval(timer);
        resolve();
      }
    }, 100);
  }));
}

const shotImg = {
  async genImg(url, path, width, height) {
    try {
      await puppeteerManager.withPage(async page => {
        await page.setViewport({ width: width || 1500, height: height || 1020 });
        await page.goto(url, { waitUntil: 'networkidle2', timeout: 60000 });
        await autoScroll(page);
        await page.screenshot({ path, fullPage: true, omitBackground: true });
      });
      return true;
    } catch (err) {
      console.error('Screenshot generation failed:', err);
      return false;
    }
  }
};

module.exports = shotImg;
