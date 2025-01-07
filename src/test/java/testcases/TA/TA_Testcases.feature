Feature:
  Background:

    * startConfig('chrome_local')
#    * def accountData = data('TA', 'accounts')
    * def homePage = business('TA', 'homePage')
    * def cartPage = business('TA', 'cartPage')
    * def shopPage = business('TA', 'shopPage')
    * def checkoutPage = business('TA', 'checkoutPage')

    ## Set variables
    * def expectedMessage = 'YOUR SHOPPING CART IS EMPTY'
    * def expectedQuantity = '1'
    * def prodName = "AirPods"
    * def activeStyleColor = 'rgb(34, 34, 34)'
    * def inactiveStyleColor = 'rgb(154, 154, 154)'
    * def firstName = generateRandomString(5)
    * def lastName = generateRandomString(7)
    * def country =  "Vietnam"
    * def address = generateRandomString(12)
    * def cities = ["Ho Chi Minh", "Da Nang", "Hue"]
    * def city =  cities[Math.floor(Math.random() * 3)]
    * def phone = "090" + String(Math.floor(Math.random() * 10000000)).padStart(7, '0')
    * def zipCode = String(Math.floor(Math.random() * 10000000)).padStart(7, '0')
    * def emailStr = firstName + "." + lastName + "." + getCurrentYear()+ getCurrentMonth() + getCurrentDate() + "@mailinator.com"
    * def email = emailStr.toLowerCase()
    * def paymentMethod = "Cash on delivery"
    * def thankyouMessage = "THANK YOU. YOUR ORDER HAS BEEN RECEIVED."


  Scenario: Verify puchasing by a Guest
  #Step 1: Go to homepage
    * call homePage.navigateToApp
    * call homePage.waitForHomePageURL

  #Step 2: Click on Cart icon in the top right of shopping page
    * call homePage.clickCartIcon
    * call cartPage.waitForCartURL

    #VP: Message is shown: YOUR SHOPPING CART IS EMPTY
    * def currentMessage = call cartPage.getMessageText
    * match currentMessage.result == expectedMessage

    #Step 3: Click on "Return to Shop" button
    * call cartPage.clickReturnToShop

    #VP: SHOP page is shown
    * call shopPage.waitForShopURL
    * call shopPage.clickToClosePopUp

    #Step 4:  Click on Cart icon to add a product
    * call shopPage.addProductToCart {productName : '#(prodName)'}
    #VP: Cart icon number at the top right of shopping page is increased correctly
    * call shopPage.waitForAddedMsg
    * call shopPage.getQuantityProductInCart
    * def quatityCartNumber = call shopPage.getQuantityProductInCart
    * match quatityCartNumber.result.trim() == expectedQuantity

    #Step 5: Click on Cart icon in the top right of shopping page
    * call shopPage.clickCartIcon
    * call cartPage.waitForCartURL

    #VP: Progress is shown correctly: SHOPPING Cart is black bold while CHECKOUT and ORDER STATUS is grey
    * def shoppingCartColor = call cartPage.getShoppingCartLinkStyleColor
    * def checkOutColor = call cartPage.getCheckOutStyleColor
    * def orderStatusColor = call cartPage.getOrderStatusStyleColor
    * match shoppingCartColor.result == activeStyleColor
    * match checkOutColor.result == inactiveStyleColor
    * match orderStatusColor.result == inactiveStyleColor

    #VP: SHOPPING CART page shows the corrected item (name, price, quantity, total)
    * def actualProdPrice = call cartPage.getProductPrice {productName : '#(prodName)'}
    * def actualProdQuantity = call cartPage.getProductQuantity {productName : '#(prodName)'}
    * def isTitleExists = call cartPage.findProductTitle {productName : '#(prodName)'}
    * def actualProdSubTotal = call cartPage.getProductSubTotal {productName : '#(prodName)'}
    * match actualProdPrice.result == '$290.00'
    * match actualProdQuantity.result ==  '1'
    * match isTitleExists.result == true
    * match actualProdSubTotal.result == '$290.00'

    #Step 6: Click on "Process to checkout" button
    * call cartPage.clickProcessToCheckout
    * call checkoutPage.waitForCheckoutURL

    #VP: Progress is shown correctly: SHOPPING Cart and CHECKOUT are black bold while  ORDER STATUS is grey
    * def shoppingCartColor = call cartPage.getShoppingCartLinkStyleColor
    * def checkOutColor = call cartPage.getCheckOutStyleColor
    * def orderStatusColor = call cartPage.getOrderStatusStyleColor
    * match shoppingCartColor.result == activeStyleColor
    * match checkOutColor.result == activeStyleColor
    * match orderStatusColor.result == inactiveStyleColor

    #Step 7" Enter required fields then click on "Place Order" button
    * call checkoutPage.createAccount { "firstName": "#(firstName)", "lastName": "#(lastName)","country": "#(country)","address": "#(address)", "zipCode": "#(zipCode)" ,"city": "#(city)","phone": "#(phone)","email": "#(email)","createAccValue": "#(createAccountValueSetting)","paymentType":"#(paymentMethod)"}
    #VP:
    # Message is shown: "THANK YOU. YOUR ORDER HAS BEEN RECEIVED."
    * def actualMsg =  call checkoutPage.getThankYouMessage
    * match actualMsg.result.toUpperCase() == thankyouMessage

    #Order info is shown correctly:
    #- Order number: a number
    #- Date: today
    #- Total: corrected price
    #- Payment method: Cash on Delivery
    #- Product: correct name as at step 4
    #- Email: corrected email address
    * def actualOderCode = call checkoutPage.getOrderCode
    * def actualOrderDate = call checkoutPage.getOrderDate
    * def actualPaymentMethod = call checkoutPage.getOrderPaymentMethod
    * match isNumber(Number(actualOderCode.result)) == true
    * match actualOrderDate.result == getCurrentDateAndFormat()
    * match actualPaymentMethod.result == paymentMethod
    * def actualOrderTotal = call checkoutPage.getOrderTotal
    * def isProductExists = call checkoutPage.getOrderProductInformation {productName : '#(prodName)'}
    * match actualOrderTotal.result == '$290.00'
    * match isProductExists.result == true


