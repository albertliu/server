const puppeteer = require('puppeteer');
  async function autoScroll(page1) {
    return page1.evaluate(() => {
        return new Promise((resolve, reject) => {
            //滚动的总高度
            var totalHeight = 0;
            //每次向下滚动的高度 100 px
            var distance = 100;
            var timer = setInterval(() => {
                //页面的高度 包含滚动高度
                var scrollHeight = document.body.scrollHeight;
                //滚动条向下滚动 distance
                window.scrollBy(0, distance);
                totalHeight += distance;
                //当滚动的总高度 大于 页面高度 说明滚到底了。也就是说到滚动条滚到底时，以上还会继续累加，直到超过页面高度
                if (totalHeight >= scrollHeight) {
                    clearInterval(timer);
                    resolve();
                }
            }, 100);
        })
    });
  }
const shotImg = {
  async genImg(pdf_string, path, w, h) {
    const browser = await puppeteer.launch({
      args: ['--no-sandbox', '--start-maximized'],
    });
    const page = await browser.newPage();
    try {
      // 设置浏览器视窗
      await page.setViewport({
        width: w || 2160,
        height: h || 1020
      })
      await page.goto(pdf_string, {
        waitUntil: 'networkidle2',  //networkidle0：页面加载后不存在 0 个以上的资源请求，这种状态持续至少 500 ms; networkidle2：页面加载后不存在 2 个以上的资源请求，这种状态持续至少 500 ms。
        timeout: 60000  //最长的加载时间60s
      });//默认30秒超时，见文档
      await autoScroll(page);
      await page.screenshot({
        path: path,  //保存路径（带文件名），可以根据扩展名自动判断图片格式。如果路径为空，则返回buffer
        fullPage: true, //支持页面滚动到最后。
        omitBackground: true
      });
      await browser.close(); //关闭 
    } catch (err) {
      await browser.close(); //关闭
      console.log("shot err:", err);
    }
}

}

module.exports = shotImg;