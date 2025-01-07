Feature: sample karate test script
for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * startConfig("chrome")
    * def controls = locator('HRM', 'basepage')

  Scenario: Log in
    * driver 'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'
    * call HRM.login
    * call HRM.selectSideMenu {item: 'Time'}
    * mouse(format(controls.topBarMenu, 'Timesheets ')).click()
    * mouse(format(controls.topSubmenuItem, 'My Timesheets')).click()
    * if (!exists(format(controls.dynamicBtn, ' Edit ')))  click(controls.preBtn)
    * waitFor(format(controls.dynamicBtn, ' Edit '))
    * click(format(controls.dynamicBtn, ' Edit '))
    * waitForUrl('/editTimesheet')
    * waitFor("//i[@class='oxd-icon bi-trash']")
    * click("//i[@class='oxd-icon bi-trash']")
#    * if (exists('oxd-icon bi-trash'))  click('oxd-icon bi-trash')
    * input(format(controls.dynamicInput, 'Project'), 'Apache Software Foundation')
    * waitFor(format(controls.dynamicSuggestionOption, 'Apache Software Foundation'))
    * mouse(format(controls.dynamicSuggestionOption, 'Apache Software Foundation')).click()
    * mouse(controls.activitySelection).click()
    * scroll(format(controls.itemOption, 'Feature Development'))
    * mouse(format(controls.itemOption, 'Feature Development')).click()
    * def elements = locateAll(controls.dynamicTimeDayInput)
#    * def fun = function(x){ karate.appendTo(res, x * x) }
    * def fn =
      """
      function(){
        for(var i = 0; i < 7; i++){
          elements[i].input('8')
        }

      }
      """
    * eval fn()
    * click(format(controls.dynamicBtn, ' Save '))
    * waitFor(controls.successfulDialog)
    * match text(controls.successfulDialog) == 'Successfully Saved'

