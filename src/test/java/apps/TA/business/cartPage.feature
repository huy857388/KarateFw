@ignore
Feature: Cart Page
  Background:
    * def controls = locator('TA','cartPage')

  @methods @parent=TA.generalPage
  Scenario:
    * def parent = parentBusiness()
    * print 'DEFAULT methods is load'
    * def featurePath = feature('TA','cartPage','cartPage')
    * def getMessageText = method(featurePath, '@getMessageText')
    * def clickReturnToShop = method(featurePath,'@clickReturnToShop')
    * def waitForCartURL = method(featurePath,'@waitForCartURL')
    * def getProductPrice = method(featurePath,'@getProductPrice')
    * def findProductTitle = method(featurePath,'@findProductTitle')
    * def getProductQuantity = method(featurePath,'@getProductQuantity')
    * def getProductSubTotal = method(featurePath,'@getProductSubTotal')
    * def clickProcessToCheckout = method(featurePath,'@clickProcessToCheckout')
    * def getShoppingCartLinkStyleColor = method(featurePath,'@getShoppingCartLinkStyleColor')
    * def getCheckOutStyleColor = method(featurePath,'@getCheckOutStyleColor')
    * def getOrderStatusStyleColor = method(featurePath,'@getOrderStatusStyleColor')
  @getMessageText
  Scenario: return true or false if message text exists
    * print 'Check message exist'
    * def result = text(controls.messageText)

  @clickReturnToShop
  Scenario: Click on Return to Shop
  * print 'Click on Return to Shop'
  * click(controls.returnToShopButton)

  @waitForCartURL
  Scenario: Wait for Shop URL load
  * print 'Wait for Shop URL load'
  * waitForUrl('/cart')

  @getProductPrice
  Scenario: Get Product Price
    * print 'Get Product Price'
    * def productItem = format(controls.productPriceText, productName)
    * def result = text(productItem).trim()
    * print result

  @findProductTitle
  Scenario: Get Product Title
    * print 'Get Product Title'
    * def productItem = format(controls.productTitleText, productName)
    * def result = exists(productItem)

  @getProductQuantity
  Scenario: Get Product Quantity
    * print 'Get Product Quantity'
    * def productItem = format(controls.productQuantityText, productName)
    * def result = value(productItem)

  @getProductSubTotal
  Scenario: Get Product SubTotal
    * print 'Get Product SubTotal'
    * def productItem = format(controls.productSubTotalText, productName)
    * def result = text(productItem).trim()

  @clickProcessToCheckout
  Scenario: Click on Process To Checkout button
    * print 'Click on Process To Checkout button'
    * click(controls.processToCheckoutButton)

  @getShoppingCartLinkStyleColor
  Scenario: Click on Process To Checkout button
    * print 'Get Style color of Shopping Cart Link'
    * def result = script(controls.shoppingCartLink, "function(e){ return getComputedStyle(e).color}")

  @getCheckOutStyleColor
  Scenario: Click on Process To Checkout button
    * print 'Get Style color of check Out Link'
    * def result = script(controls.checkOutLink, "function(e){ return getComputedStyle(e).color}")

  @getOrderStatusStyleColor
  Scenario: Click on Process To Checkout button
    * print 'Get Style color of order Status'
    * def result = script(controls.orderStatusLink, "function(e){ return getComputedStyle(e).color}")

