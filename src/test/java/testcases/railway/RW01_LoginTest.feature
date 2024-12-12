Feature: sample karate test script
for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * startConfig("chrome")
    * def loginpage = locator('railway', 'loginpage')
    * def userData = data('railway', 'users')
    * def appData = data('railway', 'appData')
    * def homePage = locator('railway', 'homepage')

  Scenario: Log in
    # 1. Navigate tp railway
    * driver appData.url

    # 2. Click Log In
    * click(homePage.logInLink)

    # 3. Input username and password then log in
    #* call railway.login
    * input(loginpage.usernameTextbox, userData.validUser.username)
    * input(loginpage.passwordTextbox, userData.validUser.password)
    * click(loginpage.loginButton)

    # VP. Check User log in successfully
    * match exists(homePage.welcomeText) == true