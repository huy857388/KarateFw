Feature: sample karate test script
for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * startConfig("chrome")
    * def controls = locator('HRM', 'basepage')

  Scenario: Log in
    * driver 'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'
    * call HRM.login
    * call HRM.selectSideMenu {item: 'Leave'}
    * mouse(format(controls.topBarMenu, 'Apply')).click()
    * mouse(format(controls.dynamicListBox, 'Leave Type')).click()
    * mouse(format(controls.itemOption, 'CAN - FMLA')).click()
    * def func =
      """
      function(){
        var d = new Date()
        var y = d.getFullYear()
        var m = d.getMonth()+1;
        var lastDay = new Date(y, m, 0);
        return y +'-'+ lastDay.getDate() +'-' + m
      }
      """
    * def fromDate = getCurrentYear() + "-01-" + getCurrentMonth()
    * input(format(controls.dynamicInput, 'From Date'), fromDate)
    * click(format(controls.dynamicInput, 'To Date'))
    * clear(format(controls.dynamicInput, 'To Date'))
    * input(format(controls.dynamicInput, 'To Date'), func())


