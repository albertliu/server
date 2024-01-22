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
  async genImg(pdf_string, path, s) {
      const browser = await puppeteer.launch({
        args: ['--no-sandbox', '--start-maximized'],
      });
      const page = await browser.newPage();
      try {
        // 设置浏览器视窗
        await page.setViewport({
          width: 720,
          height: 2500,
          deviceScaleFactor: 1
        })
        await page.goto(pdf_string, {
          waitUntil: 'networkidle2',  //networkidle0：页面加载后不存在 0 个以上的资源请求，这种状态持续至少 500 ms; networkidle2：页面加载后不存在 2 个以上的资源请求，这种状态持续至少 500 ms。
          timeout: 60000  //最长的加载时间60s
        });//默认30秒超时，见文档
        // await page.content();
        // const base64 = await page.screenshot({
        //   //path: 'views/hn.jpg',
        //   path: path,  //保存路径（带文件名），可以根据扩展名自动判断图片格式。如果路径为空，则返回buffer
        //   type: 'jpeg',  //图片格式，jpeg,png. 默认png。
        //   quality: s, //图片质量 0-100. png格式不可用。
        //   fullPage: true, //支持页面滚动到最后。
        //   omitBackground: false,  //将白色背景设为透明。默认false(不透明)
        //   encoding: "base64"  //编码类型 base64, binary(默认)
        // });
        // // console.log("shot base64:", base64.substr(0,100));
        // await browser.close(); //关闭   
        // // const img = new Buffer.from(base64, "base64");
        // return ("data:image/png;base64," + base64);
        await autoScroll(page);
        await page.screenshot({
          path: path,  //保存路径（带文件名），可以根据扩展名自动判断图片格式。如果路径为空，则返回buffer
          type: 'jpeg',
          quality: s,
          fromSurface: false,
          omitBackground: false,
          fullPage: true //支持页面滚动到最后。
        });
        await browser.close(); //关闭 
      } catch (err) {
        await browser.close(); //关闭
        console.log("shot err:", err);
      }
  }

}

module.exports = shotImg;