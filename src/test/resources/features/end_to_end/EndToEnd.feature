#language: en

@regression @endToEnd
Feature: End to End

  # FIXME: adjust scenario description
  Scenario Outline: End to end scenario
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file <registerRequestBody>
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    # Login
    Given remove body
    And add body from json file <loginRequestBody>
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And validate response body
      | token.length() > 0               | {BOOLEAN}true |
      | token.split('\\\\.').size() == 3 | {BOOLEAN}true |
    And save response data
      | loginTokenVar | token |

    # Retrieve Data
    Given remove body
    And add headers
      | loginToken | {STORAGE}loginTokenVar |
    And send a get to http://localhost:8080/v1/user
    Then validate response status equals 200
    And validate response body
      | nickname == 'testingGuy' | {BOOLEAN}true |


    Examples:
      | registerRequestBody | loginRequestBody |
      | register.json       | login.json       |