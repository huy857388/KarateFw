Feature: windows calculator
  Background:
    * def notePad = business('winApp', 'winApp32')
    * robot { window: '^Notepad', fork: 'notepad', highlight: true, highlightDuration: 500 }
    * robot.window('^Notepad').maximize()
    * def inputText = 'This is a test note.'
    * def pathFile = '//pane{Control Host}/{Tree View}/{Desktop}/{This PC}/{Desktop}'
    * def fileName = 'TestNote'
    * def inputText = 'This is a test note.'
    * def findText = 'note'
    * def replaceText = 'document'

  Scenario:
    * call notePad.inputText {inputText: '#(inputText)'}
    * call notePad.saveAsFile
    * call notePad.closeApp
    * karate.fork('C:/Windows/System32/notepad.exe')
    * call notePad.openExistedFile {fileName: '#(fileName)', path: '#(pathFile)'}
    * def text = call notePad.getTextContent
    * match text.result == inputText

  Scenario:
    * call notePad.openExistedFile {fileName: '#(fileName)', path: '#(pathFile)'}
    * call notePad.selectFontOptions {fontStyle: null, font: null, size: '19'}

  Scenario:
    * call notePad.openExistedFile {fileName: '#(fileName)', path: '#(pathFile)'}
    * call notePad.replaceText { findText: '#(findText)', replaceText: '#(replaceText)' }
    * call notePad.saveFile
    * def result = call notePad.findNotExistText { text: '#(findText)' }
    * match result.result contains 'Cannot find'


