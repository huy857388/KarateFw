@ignore
Feature: Home Page
  Background:
    * def controls = locator('TA','homePage')
    * def appData = data('TA','appData')

  @methods @parent=TA.generalPage
  Scenario:
  * def parent = parentBusiness()
  * print 'DEFAULT methods is load'
  * def featurePath = feature('TA','homePage','homePage')
  * def waitForHomePageURL = method(featurePath, '@waitForHomePageURL')

  @waitForHomePageURL
  Scenario: wait for URL load
  * print 'Wait for Home Page URL load'
  * waitForUrl(appData.url)


