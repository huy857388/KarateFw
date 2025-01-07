Feature:
  Background:
    * def controls = locator('HRM', 'basepage')

  Scenario:
#    * call HRM.selectSideMenu {item: 'Recruitment'}
    * click(format(controls.topBarMenu, 'Vacancies'))
    * waitForUrl('/viewJobVacancy')
    * waitFor(format(controls.dynamicDeleteBtn, 'huy'))
    * click(format(controls.dynamicDeleteBtn, 'huy'))
    * waitFor(format(controls.dynamicBtn, ' Yes, Delete '))
    * click(format(controls.dynamicBtn, ' Yes, Delete '))
