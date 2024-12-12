Feature: Test JSONPlaceholder API

  Background:
    * url 'https://jsonplaceholder.typicode.com'
    * def postPayload =
      """
      {
        "title": "This is sample test",
        "body": "This is body of sample test",
        "userId": 1
      }
      """

  Scenario: Create a new post
    Given path '/posts'
    And request postPayload
    When method POST
    Then status 201
    And match response ==
      """
      {
        "title": "This is sample test",
        "body": "This is body of sample test",
        "userId": 1,
        "id": '#present'
      }
      """
    And def current_id = response.id
    * print "Post created, id:" + current_id

  Scenario: Retrieve an existing post
    Given path '/posts/1'
    When method GET
    Then status 200
    And match response contains
      """
      {
        "id": 1,
        "userId": '#notnull'
      }
      """

  Scenario: Update an existing post
    Given path '/posts/1'
    And request
      """
      {
        "id": 1,
        "title": "updated title",
        "body": "updated body",
        "userId": 1
      }
      """
    When method PUT
    Then status 200
    And match response.title == "updated title"
    And match response.body == "updated body"

  Scenario: Delete a post
    Given path '/posts/1'
    When method DELETE
    Then status 200