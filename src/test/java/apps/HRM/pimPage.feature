Feature:
  Background:
    * def controls = locator('HRM', 'pimPage')
    * def featurePath = feature('HRM','pimPage','pimPage')
    * def parent = parentBusiness()

  @methods @parent=HRM.generalPage
  Scenario:
    * print 'DEFAULT methods is load'
    * def addEmployee = method(featurePath, '@addEmployee')

  @addEmployee
  Scenario:
#    * karate.call('@parent')
#    * print parent.controls.dynamicBtn
    * def selectSideMenu = karate.call('@parent').method(featurePath, '@selectSideMenu')
    * call selectSideMenu