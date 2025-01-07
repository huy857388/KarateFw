Feature: sample karate test script
for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * startConfig("chrome")
    * def controls = locator('HRM', 'basepage')

  Scenario: Log in
    # 1. Navigate tp railway
    * driver 'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'

    # 3. Input username and password then log in
    * call HRM.login
    * call HRM.selectSideMenu {item: 'PIM'}
    * click(format(controls.dynamicBtn, ' Add '))
    * waitForUrl('/addEmployee')
    * input(controls.firstNameInput, 'huy')
    * input(controls.middleNameInput, 'minh')
    * input(controls.lastNameInput, 'pham')
    * input(controls.employeeIdInput, '042911')
    * click(controls.pictureBtn)
    * robot { window: '^Open', highlight: true, highlightDuration: 500 }
    * robot.waitForWindowOptional('^Open').optional('//pane{Control Host}/{^Tree View}').scroll(50,50)
    * robot.windowOptional('^Open').locate('//pane{Control Host}/{Tree View}/{Desktop}/{This PC}/{Downloads}').click()
    * robot.windowOptional('^Open').locate('download').click()
    * robot.windowOptional('^Open').locateAll('//button{Open}')[2].click()
    * waitFor(format(controls.dynamicBtn, ' Save '))
    * click(format(controls.dynamicBtn, ' Save '))





