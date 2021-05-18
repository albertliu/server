const puppeteer = require('puppeteer');

const pdf ={
  async genPDF(pdf_string, path, w, h, p, land, s) {
    const browser = await puppeteer.launch({
      args: ['--disable-dev-shm-usage', '--no-sandbox'],
    });
    const page = await browser.newPage();
    await page.goto(pdf_string);
    await page.pdf({
      //path: 'views/hn.pdf',
      path: path, 
      //format: 'A4',
      width: w,
      height: h,
      pageRanges: p,
      scale: s,
      landscape: land,
      displayHeaderFooter: false,
      printBackground: false,
      margin:{
        top:10,
        bottom:10,
        left:10,
        right:10
      }
    });
  
    await browser.close();    
  }
}

module.exports = pdf;