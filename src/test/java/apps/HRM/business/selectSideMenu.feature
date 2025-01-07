Feature:
  Background:
    * def controls = locator('HRM', 'basepage')

  Scenario:
    * def sideMenu = format(controls.sideMenuItem, item)
    * click(sideMenu)
    * waitForUrl('/'+karate.lowerCase(item))



