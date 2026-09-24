@regression @invalidData @invalidDataGet @get
Feature: invalid data get service

  @getWithInvalidToken
  Scenario: Try to get a user with an invalid token
    Given add authorization header
    And add headers
      | loginToken | invalid-login-token |
    When send a get to http://localhost:8080/v1/user
    Then validate response status equals 401
    And validate response body
      | message | {STRING}Invalid login token |

  @getUserNoLongerExists
  Scenario: Try to get a user that no longer exists
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | getUserNoLongerExists             |
      | email    | getusernolongerexists@testing.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given remove body
    And add body from json file login.json changing data
      | email | getusernolongerexists@testing.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |

    Given remove body
    And add headers
      | loginToken | {STORAGE}loginTokenVar |
    When send a delete to http://localhost:8080/v1/user
    Then validate response status equals 204

    When send a get to http://localhost:8080/v1/user
    Then validate response status equals 404
    And validate response body
      | message | {STRING}User not found |
