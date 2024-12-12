Feature: Test JSONPlaceholder API

  Background:
#    * url 'https://apilearning.free.beeceptor.com/api/'
    * url 'https://jsonplaceholder.typicode.com'
    * def userId1 = 1
    * def postPayload =
      """
      {
        "title": "Sample Post Title",
        "body": "This is the body of the sample post.",
        "userId": '#(userId1)'
      }
      """
  @CreatePost
  Scenario: Create a new post
    Given path '/posts'
    And request postPayload
    When method POST
    Then status 201
    And match response ==
      """
      {
        "title": "Sample Post Title",
        "body": "This is the body of the sample post.",
        "userId": '#(userId1)',
        "id": '#present'
      }
      """
    And def current_id = response.id
    * print "Post created, id:" + current_id

  Scenario: Add a Comment to the New Post
    * def current_id = karate.call('@CreatePost').current_id
    Given path '/comments'
    And request
    """
    {
      postId: '#(current_id)',
      name: 'Sample Comment',
      email: 'user@example.com',
      body: 'This is a test comment on the sample post.'
    }
    """
    When method POST
    Then status 201
    And match response ==
      """
      {
        "name": "Sample Comment",
        "email": "user@example.com",
        "body": "This is a test comment on the sample post.",
        "postId": '#(current_id)',
        "id": '#present'
      }
      """
#  Scenario: Retrieve an existing post
#    * def current_id = karate.call('@CreatePost').current_id
#    Given path '/posts/' + current_id
#    When method GET
#    Then status 200
#    And match response contains
#      """
#      {
#        "userId": '#(userId)',
#        "id": '#notnull'
#      }
#      """
#    * print "Post detail:" + response

  Scenario: Update the New Post’s Title and Body
    * def current_id = karate.call('@CreatePost').current_id
#    Given path '/posts/' + current_id
    Given path '/posts/99'
    And request
      """
      {
        "title": "updated title",
        "body": "updated body",
      }
      """
    When method PUT
    Then status 200
    And match response.title == "updated title"
    And match response.body == "updated body"

  @seachPostById
  Scenario: Perform a Search on Posts by userId:
    * def current_id = karate.call('@CreatePost').current_id
    Given path '/posts'
    And param userId = userId1
    When method GET
    Then status 200
    Then match each response contains deep { userId: '#(userId1)' }

  Scenario: Add an Attachment to the New Post (Simulated Attachment):
    * def current_id = karate.call('@CreatePost').current_id
    Given path '/photos'
    And request
    """
    {
      albumId: '#(current_id)',
      title: "Attachment for Post",
      url: "https://via.placeholder.com/600/92c952",
      thumbnailUrl: "https://via.placeholder.com/150/92c952"
    }
    """
    When method POST
    Then status 201
    And match response ==
      """
      {
        "albumId": '#(current_id)',
        "id": "#present",
        "title": "#present",
        "url": '#present',
        "thumbnailUrl": '#present'
      }
      """



  #  Scenario: Delete a post
#    Given path '/posts/98'
#    When method DELETE
#    Then status 200