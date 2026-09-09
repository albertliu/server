const puppeteerManager = require('./puppeteerManager');

const pdf = {
  async genPDF(pdfStrings, paths, width, height, pageRanges, landscape, scale, printBackground) {
    try {
      await puppeteerManager.withPage(async page => {
        for (let i = 0; i < pdfStrings.length; i++) {
          await page.goto(pdfStrings[i], { waitUntil: 'networkidle0' });
          await page.pdf({
            path: paths[i],
            width,
            height,
            pageRanges,
            scale,
            landscape,
            displayHeaderFooter: false,
            printBackground,
            margin: { top: 10, bottom: 10, left: 10, right: 10 }
          });
        }
      });
      return true;
    } catch (err) {
      console.error('PDF generation failed:', err);
      return false;
    }
  }
};

module.exports = pdf;
