Feature: Perform a Google Search

  Background:
    * startConfig('chrome_local')
    * driver 'https://www.google.com'

  Scenario: Search for a keyword on Google
    Given input("[name='q']", ['Karate UI Testing', Key.ENTER])
    Then waitFor("h3")
    And match text("h3") contains 'Karate'