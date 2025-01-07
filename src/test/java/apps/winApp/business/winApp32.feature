Feature:
  Background:
    * def featurePath = feature('winApp','winApp32')

  @methods
  Scenario:
    * print 'DEFAULT methods is load'
    * def select = method(featurePath, '@select')
    * def inputText = method(featurePath, '@inputText')
    * def saveAsFile = method(featurePath, '@saveAsFile')
    * def openExistedFile = method(featurePath, '@openExistedFile')
    * def closeApp = method(featurePath, '@closeApp')
    * def getTextContent = method(featurePath, '@getTextContent')
    * def selectFontOptions = method(featurePath, '@selectFontOptions')
    * def replaceText = method(featurePath, '@replaceText')
    * def saveFile = method(featurePath, '@saveFile')
    * def findText = method(featurePath, '@findText')
    * def findNotExistText = method(featurePath, '@findNotExistText')
    * def printCurrentDate = method(featurePath, '@printCurrentDate')
    * def checkCurrentDate = method(featurePath, '@checkCurrentDate')

  @inputText
  Scenario:
    * robot.click('Text Editor')
    * robot.input(inputText)

  @saveAsFile
  Scenario:
    * robot.click('File')
    * robot.click('#3')
    * robot.waitForWindowOptional('Save As').locate('//pane{Control Host}/{Tree View}/{Desktop}/{This PC}/{Desktop}').click()
    * robot.waitForWindowOptional('Save As').locate('//Edit{File name:}').input('TestNote.txt')
    * robot.waitForWindowOptional('Save As').locate('Save').click()
    * if (windowExists('Confirm Save As')) robot.waitForWindowOptional('Confirm Save As').locate('Yes').click()

  @closeApp
  Scenario:
    * robot.window('^Notepad').close()

  @openExistedFile
  Scenario:
    * robot.window('Untitled - Notepad').maximize()
    * robot.click('File')
    * robot.click('#2')
    * robot.waitForWindowOptional('Open').locate(path).click()
    * windowOptional('Open').locate(fileName).click()
    * windowOptional('Open').locateAll('//button{Open}')[3].click()
    * robot.waitForWindowOptional(fileName + ' - Notepad')

  @getTextContent
  Scenario:
    * def result = robot.locate('^Text Editor').value

  @selectFontOptions
  Scenario:
    * robot.click('Format')
    * robot.click('Font...')
    * robot.waitForWindowOptional('Font')
    * eval
      """
      if (font != null) {
      robot.waitForWindowOptional('Font').locate('//Edit{Font:}').input(font)
      robot.waitForWindowOptional('Font').locate('//ComboBox{Font:}/{Font:}/{' + font + '}').click()
      }
      """
    * eval
      """
      if (fontStyle != null) {
      robot.waitForWindowOptional('Font').locate('//Edit{Font style:}').input(fontStyle)
      robot.waitForWindowOptional('Font').locate('//ComboBox{Font style:}/{Font style:}/{' + fontStyle + '}').click()
      }
      """
    * eval
      """
      if (size != null) {
      robot.waitForWindowOptional('Font').locate('//Edit{Size:}').input(size)
      }
      """
    * robot.waitForWindowOptional('Font').click('OK')

  @replaceText
  Scenario:
    * input(Key.CONTROL + 'h')
    * robot.waitForWindowOptional('Replace')
    * windowOptional('Replace').locate('//Edit{Find what:}').input(findText)
    * windowOptional('Replace').locate('//Edit{Replace with:}').input(replaceText)
    * def fun = function(){ return optional('Replace All').enabled }
    * waitUntil(fun)
    * windowOptional('Replace').locate('Replace All').click()
    * windowOptional('Replace').locate('Cancel').click()

  @saveFile
  Scenario:
    * input(Key.CONTROL + 's')
    * match windowExists('\*^') == false

  @findText
  Scenario:
    * input(Key.HOME)
    * input(Key.CONTROL + 'f')
    * robot.waitForWindowOptional('Find')
    * windowOptional('Find').locate('//Edit{Find what:}').input(findText)
    * windowOptional('Find').locate('Down').click()
    * windowOptional('Find').locate('Find Next').click()

  @findNotExistText
  Scenario:
    * def findText = method(featurePath, '@findText')
    * call findText { findText: '#(text)'}
    * def result = robot.waitForWindowOptional('Notepad').locate('#65535').name

  @printCurrentDate
  Scenario:
    * robot.click('Edit')
    * robot.click("//MenuItem{^Time}")

  @checkCurrentDate
  Scenario:
    * def pirntText = robot.locate('^Text Editor').value
    * def func =
      """
      function(arg){
        var getText = new Date(pirntText)
        var currentDate = new Date()
        return getText.toLocaleDateString() == currentDate.toLocaleDateString()
      }
      """
    * def result = func()