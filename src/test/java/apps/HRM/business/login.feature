Feature:
  Background:
    * def controls = locator('HRM', 'loginPage')

  Scenario:
    * waitFor(controls.loginInput)
    * input(controls.loginInput, 'Admin')
    * input(controls.passwordInput, 'admin123')
    * click(format(controls.dynamicBtn, ' Login '))
    * waitForUrl('/dashboard/index')
