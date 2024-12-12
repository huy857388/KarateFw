@ignore
Feature: Select top menu
  Background:
    * def controls = locator('railway', 'loginpage')
    * def userData = data('railway', 'users')

  Scenario: Select top menu
    * print 'DEFAULT: login to railway'
    * input(controls.usernameTextbox, userData.validUser.username)
    * input(controls.passwordTextbox, userData.validUser.password)
    * click(controls.loginButton)