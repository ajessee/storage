// require playwright and launch browser
const { firefox } = require('playwright');
(async () => {
  const browser = await firefox.launch({ headless: false });
  searchBestBuyForPS5(browser);
})();

// helper function for sleeping
const sleep = (milliseconds) => {
  return new Promise(resolve => setTimeout(resolve, milliseconds))
}

// search whether PS5 is in stock at Best Buy
var searchBestBuyForPS5 = async (browser) => {
  // go to Best Buy's site
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto('https://www.bestbuy.com');

  // enter search term "playstation 5 console"
  await page.type('#gh-search-input', 'playstation 5 console', {delay: 100});
  await sleep(3000);
  await page.press('.header-search-button', 'Enter');
  await sleep(1000);

  // wait for result products to render and put them in a results array
  await page.innerHTML('li.sku-item');
  const results = await page.$$('li.sku-item');

  // iterate through results array
  for (let i = 0; i < results.length; i++) {
    // get product's name
    const skuHeader = await results[i].$('h4.sku-header');
    const html = await skuHeader.innerHTML();

    // check whether product's name contains "playstation 5" and "console"
    if (html.toLowerCase().includes('playstation 5') && html.toLowerCase().includes('console')) {
      // get Sold Out/Add to Cart button
      const button = await results[i].$('button.add-to-cart-button');
      const buttonText = await button.innerText();

      // if the product is not sold out, alert the user
      if (buttonText !== "Sold Out") {
        console.log("Available!");
        // alert the user!!!
      }
    }
  }
};
