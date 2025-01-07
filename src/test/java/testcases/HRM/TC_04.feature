Feature: sample karate test script
for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * startConfig("chrome")
    * def controls = locator('HRM', 'basepage')

  Scenario: Log in
    * driver 'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'
    * call HRM.login
    * call HRM.selectSideMenu {item: 'Time'}
    * mouse(format(controls.topBarMenu, 'Reports ')).click()
    * mouse(format(controls.topSubmenuItem, 'Employee Report')).click()
    * input(format(controls.dynamicInput, 'Employee Name'), 'Joy Smith')
    * waitFor(format(controls.dynamicSuggestionOption, 'Joy Smith'))
    * mouse(format(controls.dynamicSuggestionOption, 'Joy Smith')).click()
    * click(format(controls.dynamicBtn, ' View '))

