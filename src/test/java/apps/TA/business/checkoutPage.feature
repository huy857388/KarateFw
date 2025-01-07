@ignore
Feature: Check out Page
  Background:
    * def controls = locator('TA','checkoutPage')

  @methods
  Scenario:
    * def parent = parentBusiness()
    * print 'DEFAULT methods is load'
    * def featurePath = feature('TA','checkoutPage','checkoutPage')
    * def createAccount = method(featurePath,'@createAccount')
    * def getThankYouMessage =  method(featurePath,'@getThankYouMessage')
    * def getOrderCode =  method(featurePath,'@getOrderCode')
    * def getOrderDate =  method(featurePath,'@getOrderDate')
    * def getOrderTotal =  method(featurePath,'@getOrderTotal')
    * def getOrderPaymentMethod =  method(featurePath,'@getOrderPaymentMethod')
    * def getOrderProductInformation =  method(featurePath,'@getOrderProductInformation')
#    * def waitForTheOrderDisplay = method(featurePath,'@waitForTheOrderDisplay')
    * def waitForCheckoutURL = method(featurePath,'@waitForCheckoutURL')

  @createAccount
  Scenario: create an account
    * print 'Enter fields to create an account'
    * input(controls.firstNameTextbox, firstName)
    * input(controls.lastNameTextbox,lastName)
    * select(controls.countryDropbox,"{}" + country)
    * input(controls.addressTextbox,address)
    * input(controls.zipCodeTextbox,zipCode)
    * input(controls.cityTextbox, city)
    * input(controls.phoneTextbox, phone)
    * input(controls.emailTextbox, email)
    * def paymentmethodControl = format(controls.paymentMethodOption, paymentMethod)
    * click(paymentmethodControl)
    * click(controls.placeOrderButton)

  @getThankYouMessage
  Scenario: get thank you message
    * print 'get thank you message'
    * waitFor(controls.thankYouMessageText)
    * def result = text(controls.thankYouMessageText).trim()

  @getOrderCode
  Scenario: get the order code
    * print 'get the order code'
    * def result = text(controls.orderCodeText).trim()


  @getOrderDate
  Scenario: get the order date
    * print 'get the order date'
    * def result = text(controls.orderDateText).trim()

  @getOrderTotal
  Scenario: get the order total
    * print 'get the order total'
    * def result = text(controls.orderTotalText).trim()

  @getOrderPaymentMethod
  Scenario: get the order payment method
    * print 'get the order payment method'
    * def result = text(controls.orderPaymentMethodText).trim()

  @getOrderProductInformation
  Scenario: get the order Product Name
    * print 'get the order Product Name'
    * def ProductName = format(controls.orderProductNameText, productName)
    * def ProductQuantity = format(controls.orderProductQuantityText, productName)
    * def result_1 = exists(ProductName)
    * def result_2 = exists(ProductQuantity)
    * def collectResult =
      """
      function(a, b){
      if (a==true) {
        if (b==true) return true
        }
      return false
      }
      """
    * def result = collectResult(result_1,result_2)

#  @waitForTheOrderDisplay
#  Scenario: wait for message display
#    * print 'wait for message display'
#    * waitFor(controls.orderCodeText)

  @waitForCheckoutURL
  Scenario: Wait for Shop URL load
    * print 'Wait for Shop URL load'
    * waitForUrl('/checkout')