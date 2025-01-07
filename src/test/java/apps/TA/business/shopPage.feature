Feature: Shop Page
  Background:
    * def controls = locator('TA','shopPage')

  @methods @parent=TA.generalPage
  Scenario:
    * def parent = parentBusiness()
    * print 'DEFAULT methods is load'
    * def featurePath = feature('TA','shopPage','shopPage')
    * def clickToClosePopUp = method(featurePath, '@clickToClosePopUp')
    * def addProductToCart = method(featurePath, '@addProductToCart')
#    * def getProductPrice = method(featurePath, '@getProductPrice')
    * def waitForShopURL = method(featurePath,'@waitForShopURL')

  @clickToClosePopUp
  Scenario: Click on Close button to quit the popup Window
    * print 'Click on Close button to quit the popup Window'
    * waitFor(controls.closePopUpButton)
    * click(controls.closePopUpButton)

  @addProductToCart
  Scenario: Add item to the cart
    * print 'Add Product to Cart'
    * def productItem = format(controls.addProductToCartButton, productName)
    * def addProdButton = format(controls.addToCartIcon, productName)
    * waitFor(productItem)
    * mouse().move(productItem).go()
    * click(addProdButton)

#  @getProductPrice
#  Scenario: Get price of product
#    * print 'Get price of product'
#    * def result = text(format(controls.productPriceText, productName))

  @waitForShopURL
  Scenario: Wait for Shop URL load
    * print 'Wait for Shop URL load'
    * waitForUrl('/shop')



