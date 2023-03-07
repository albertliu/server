const puppeteer = require('puppeteer');

const pdf ={
  async genPDF(pdf_string, path, w, h, p, land, s, pb) {
    const browser = await puppeteer.launch({
      args: ['--disable-dev-shm-usage', '--no-sandbox', '--disable-pdf-tagging'],
    });
    const page = await browser.newPage();
    try {
      /*
      await page.goto(pdf_string, {waitUntil: 'networkidle0'});//默认30秒超时，见文档
      await page.pdf({
        //path: 'views/hn.pdf',
        path: path, 
        //format: 'A4',
        width: w,
        height: h,
        pageRanges: p,
        scale: s,
        landscape: false,
        displayHeaderFooter: false,
        printBackground: pb,
        margin:{
          top:10,
          bottom:10,
          left:10,
          right:10
        }
      });
      */
      let len = pdf_string.length;
      for(var i = 0; i < len; i++) {
        //console.log(pdf_string[i],path[i]);
        await page.goto(pdf_string[i], {waitUntil: 'networkidle0'});//默认30秒超时，见文档
        await page.content();
        //await page.waitForNavigation({
        //  waitUntil: 'networkidle0',
        //});
        await page.pdf({
          //path: 'views/hn.pdf',
          path: path[i], 
          //format: 'A4',
          width: w,
          height: h,
          pageRanges: p,
          scale: s,
          landscape: false,
          displayHeaderFooter: false,
          printBackground: pb,
          margin:{
            top:10,
            bottom:10,
            left:10,
            right:10
          }
        });
      }      
      await browser.close(); //关闭   
    } catch (err) {
      await browser.close(); //关闭
    }  
  }
}

module.exports = pdf;