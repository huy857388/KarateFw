Feature: sample karate test script
for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * startConfig("chrome")
    * def controls = locator('HRM', 'basepage')
    * def name = 'huy'
    * configure afterScenario =
      """
      function(){
        karate.log('after scenarioss');
        karate.call(String(HRM.deleteItem))
      }
      """

  Scenario: Log in
    # 1. Navigate tp railway
    * driver 'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'

    # 3. Input username and password then log in
    * call HRM.login
    * call HRM.selectSideMenu {item: 'Recruitment'}
    * click(format(controls.topBarMenu, 'Vacancies'))
    * waitForUrl('/viewJobVacancy')
    * click(format(controls.dynamicBtn, ' Add '))
    * input(format(controls.dynamicInput, 'Vacancy Name'), name)
    * mouse(format(controls.dynamicListBox, 'Job Title')).click()
    * mouse(format(controls.itemOption, 'Account Assistant')).click()
    * input(format(controls.dynamicInput, 'Hiring Manager'), 'Joseph  Evans')
    * waitFor(format(controls.dynamicSuggestionOption, 'Joseph  Evans'))
    * mouse(format(controls.dynamicSuggestionOption, 'Joseph  Evans')).click()
    * scroll(format(controls.dynamicBtn, ' Save ')).click()
#    * waitFor(controls.successfulDialog)
#    * match text(controls.successfulDialog) == 'Successfully Saved'
    * click(format(controls.topBarMenu, 'Vacancies'))
    * waitForUrl('/viewJobVacancy')
    * waitFor(controls.vacancyName)
    * def elements = locateAll(controls.vacancyName)
    * def result =
      """
      function(text){
        for(var i = 0; i < karate.sizeOf(elements); i++){
          if(elements[i].text==text)
            return true
        }
        return false
      }
      """
    * match result(name) == true



