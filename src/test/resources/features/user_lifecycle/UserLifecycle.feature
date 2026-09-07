#language: en

@regression @endToEnd
Feature: User lifecycle

  Scenario Outline: A user can register, authenticate, update, retrieve, and delete their profile
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

    # Retrieve user data
    Given remove body
    And add headers
      | loginToken | {STORAGE}loginTokenVar |
    And send a get to http://localhost:8080/v1/user
    Then validate response status equals 200
    And validate response body
      | nickname == 'testingGuy'                                               | {BOOLEAN}true |
      | name == 'Joaquim'                                                      | {BOOLEAN}true |
      | email == 'ema*****@domain.com'                                         | {BOOLEAN}true |
      | programmingTime == 'Between 6 months and 1 year'                       | {BOOLEAN}true |
      | bornDataDTO.date == '2022-12-22'                                       | {BOOLEAN}true |
      | bornDataDTO.country == 'Brazil'                                        | {BOOLEAN}true |
      | hobbies.size() == 3                                                    | {BOOLEAN}true |
      | hobbies.containsAll('Play video games', 'Programming', 'Watch movies') | {BOOLEAN}true |

    # Update user data
    Given add body from json file <updateRequestBody>
    And send a patch to http://localhost:8080/v1/user
    Then validate response status equals 204

    # Check if data is rightly updated
    And send a get to http://localhost:8080/v1/user
    Then validate response status equals 200
    And validate response body
      | nickname == 'newNickName'                                            | {BOOLEAN}true |
      | name == 'newName'                                                    | {BOOLEAN}true |
      | email == 'ema*****@domain.com'                                       | {BOOLEAN}true |
      | programmingTime == 'More than 2 years'                               | {BOOLEAN}true |
      | bornDataDTO.date == '2023-01-15'                                     | {BOOLEAN}true |
      | bornDataDTO.country == 'Australia'                                   | {BOOLEAN}true |
      | hobbies.size() == 3                                                  | {BOOLEAN}true |
      | hobbies.containsAll('Ride a bicycle', 'Programming', 'Watch series') | {BOOLEAN}true |

    # Delete user
    And send a delete to http://localhost:8080/v1/user
    Then validate response status equals 204

    # Retrieve data again to check that user doesn't exists anymore
    And send a get to http://localhost:8080/v1/user
    Then validate response status equals 404
    And validate response body
      | message | {STRING}User not found |

    Examples:
      | registerRequestBody | loginRequestBody | updateRequestBody |
      | register.json       | login.json       | update.json       |
