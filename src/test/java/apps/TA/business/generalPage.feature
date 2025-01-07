@ignore
Feature: Base Page include: Header, Footer, common features
  Background:
    * def controls = locator('TA','generalPage')
    * def appData = data('TA','appData')

  @methods
  Scenario:
    * def parent = parentBusiness()
    * print 'DEFAULT methods is load'
    * def featurePath = feature('TA','generalPage','generalPage')
    * def navigateToApp = method(featurePath, '@navigateToApp')
    * def clickCartIcon = method(featurePath,'@clickCartIcon')
    * def getQuantityProductInCart = method(featurePath,'@getQuantityProductInCart')
    * def waitForAddedMsg = method(featurePath,'@waitForAddedMsg')

  @navigateToApp
  Scenario: navigate to app
    * print 'Navigate to url'
    * driver appData.url

  @clickCartIcon
  Scenario: click on Cart Icon
    * print 'click on Cart Icon'
    * click(controls.cartIconButton)

  @getQuantityProductInCart
  Scenario: Get quantity count in cart which show in the top right screen
    * print 'Get quantity count in cart which show in the top right screen'
    * def result = text(controls.quantityInCartText)

  @waitForAddedMsg
  Scenario: Wait for Added message
    * print 'Wait for Added message'
    * waitFor(controls.addProductSuccessful)