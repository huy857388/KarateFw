Feature: windows calculator

  Scenario:
    # start web driver

    # robot playing
    * robot { window: 'Calculator', fork: 'calc', highlight: true, highlightDuration: 500 }
    * robot.click('//button{Clear}')
    * robot.click('One')
    * robot.click('Plus')
    * robot.click('Two')
    * robot.click('Equals')
    * match robot.locate('#CalculatorResults').name == 'Display is 3'
    * robot.click('Clear')
    * robot.input('1+2=')
    * robot.input(Key.ENTER)
    * match robot.locate('#CalculatorResults').name == 'Display is 5'
    * screenshot()
    * robot.click('Close Calculator')

    # continue web driver