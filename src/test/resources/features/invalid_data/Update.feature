@regression @invalidData @invalidDataUpdate @update
Feature: invalid data update service

  @updateWithExistingNickname
  Scenario: Try to update a user with a nickname that is already registered
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateExistingNickname |
      | email    | update-existing-nickname-owner@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file register.json changing data
      | nickName | updateNicknameTarget |
      | email    | update-existing-nickname-target@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file login.json changing data
      | email | update-existing-nickname-target@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |

    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | nickName | updateExistingNickname |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}nickName                        |
      | [0].message | {STRING}This data is already in use ... |

  @updateWithInvalidToken
  Scenario: Try to update a user with an invalid token
    Given add authorization header
    And add headers
      | Content-Type | application/json |
      | loginToken   | invalid-login-token |
    And add body from json file update.json
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 401
    And validate response body
      | message | {STRING}Invalid login token |

  @updateWithInvalidNickname
  Scenario: Try to update a user with an invalid nickname
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateInvalidNicknameUser |
      | email    | update-invalid-nickname@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file login.json changing data
      | email | update-invalid-nickname@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |

    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | nickName | 123 invalid nickname |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}nickName                                                                      |
      | [0].message | {STRING}The nickname must start with a letter and cannot contain spaces, only numbers |

  @updateWithNonExistentHobby
  Scenario: Try to update a user with a non existent hobby
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateNonExistentHobby2 |
      | email    | update-non-existent-hobby2@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file login.json changing data
      | email | update-non-existent-hobby2@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |

    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | hobbies[0] | Non existent hobby |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | message | {STRING}Some hobby is invalid or duplicated! Please check the resource below to see all available options |

  @updateWithNonExistentProgrammingTime
  Scenario: Try to update a user with a non existent programming time experience
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updtNonExistentProgrammingTime |
      | email    | updating-non-existent-programming-time2@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file login.json changing data
      | email | updating-non-existent-programming-time2@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |

    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | programmingTime | Non existent programming time |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | message | {STRING}The programming time option is invalid! Please check the resource below to see all available options |

  @updateWithNonExistentCountry
  Scenario: Try to update a user with a non existent country
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateNonExistentCountry |
      | email    | update-non-existent-country@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file login.json changing data
      | email | update-non-existent-country@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |

    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | bornData.country | Non existent country |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | message           | {STRING}The country is invalid! Please check the resource below to see all available options |
      | resource.method   | {STRING}GET                                                                                  |
      | resource.endpoint | {STRING}/v1/countries                                                                        |

  @updateWithNullNickname
  Scenario: Try to update a user with a null nickname
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateNullNickname |
      | email    | update-null-nickname@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-null-nickname@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | nickName | {NULL} |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}nickName |
      | [0].message | {STRING}The nickName cannot be null or blank |

  @updateWithLongNickname
  Scenario: Try to update a user with a nickname longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateLongNickname |
      | email    | update-long-nickname@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-long-nickname@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | nickName | updateNicknameMoreThanThirtyTwoCharacters |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}nickName |
      | [0].message | {STRING}The character limit for nickName is 32 |

  @updateWithNullName
  Scenario: Try to update a user with a null name
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateNullName |
      | email    | update-null-name@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-null-name@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | name | {NULL} |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}name |
      | [0].message | {STRING}The name cannot be null or blank |

  @updateWithLongName
  Scenario: Try to update a user with a name longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateLongName |
      | email    | update-long-name@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-long-name@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | name | This name has more than sixty-four characters and should be rejected by validation |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}name |
      | [0].message | {STRING}The character limit for name is 64 |

  @updateWithInvalidName
  Scenario: Try to update a user with an invalid name format
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateInvalidName |
      | email    | update-invalid-name@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-invalid-name@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | name | Joaquim123 |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}name                                        |
      | [0].message | {STRING}The name can only contain letters and space |

  @updateWithNullPassword
  Scenario: Try to update a user with a null password
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateNullPassword |
      | email    | update-null-password@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-null-password@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | password | {NULL} |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}password |
      | [0].message | {STRING}The password cannot be null or blank |

  @updateWithLongPassword
  Scenario: Try to update a user with a password longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateLongPassword |
      | email    | update-long-password@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-long-password@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | password | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}password |
      | [0].message | {STRING}The character limit for password is 64 |

  @updateWithInvalidPassword
  Scenario: Try to update a user with an invalid password format
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateInvalidPassword |
      | email    | update-invalid-password@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-invalid-password@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | password | password with spaces |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field | {STRING}password |

  @updateWithNullProgrammingTime
  Scenario: Try to update a user with a null programming time
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateNullProgrammingTime |
      | email    | update-null-programming-time@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-null-programming-time@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | programmingTime | {NULL} |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}programmingTime |
      | [0].message | {STRING}The programmingTime cannot be null or blank |

  @updateWithLongProgrammingTime
  Scenario: Try to update a user with a programming time longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateLongProgrammingTime |
      | email    | update-long-programming-time@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-long-programming-time@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | programmingTime | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}programmingTime |
      | [0].message | {STRING}The character limit for programmingTime is 256 |

  @updateWithNullBornData
  Scenario: Try to update a user with null born data
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateNullBornData |
      | email    | update-null-born-data@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-null-born-data@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | bornData | {NULL} |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData |
      | [0].message | {STRING}The bornData cannot be null |

  @updateWithNullBirthdate
  Scenario: Try to update a user with a null birthdate
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateNullBirthdate |
      | email    | update-null-birthdate@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-null-birthdate@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | bornData.date | {NULL} |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field | {STRING}bornData.date |

  @updateWithFutureBirthdate
  Scenario: Try to update a user with a birthdate later than today
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateFutureBirthdate |
      | email    | update-future-birthdate@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-future-birthdate@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | bornData.date | 2999-12-31 |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData.date                                                                          |
      | [0].message | {STRING}The date is not valid. It must be in pattern yyyy-mm-dd and it needs to be in the past |

  @updateWithNullCountry
  Scenario: Try to update a user with a null country
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateNullCountry |
      | email    | update-null-country@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-null-country@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | bornData.country | {NULL} |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData.country |
      | [0].message | {STRING}The country cannot be null or blank |

  @updateWithLongCountry
  Scenario: Try to update a user with a country longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateLongCountry |
      | email    | update-long-country@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-long-country@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | bornData.country | This country name has more than forty-eight characters and fails |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData.country |
      | [0].message | {STRING}The character limit for country is 48 |

  @updateWithEmptyHobbies
  Scenario: Try to update a user without hobbies
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateEmptyHobbies |
      | email    | update-empty-hobbies@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-empty-hobbies@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    And add body from json file update.json changing data
      | hobbies | {EMPTY_LIST} |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}hobbies |
      | [0].message | {STRING}The hobbies cannot be null or empty |

  @updateWithMoreThanThreeHobbies
  Scenario: Try to update a user with more than three hobbies
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | updateMoreThanThreeHobbies |
      | email    | update-more-than-three-hobbies@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201
    Given add body from json file login.json changing data
      | email | update-more-than-three-hobbies@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | loginTokenVar | token |
    Given add headers
      | loginToken | {STORAGE}loginTokenVar |
    When send a get to http://localhost:8080/v1/hobbies
    Then validate response status equals 200
    And save response data
      | varHobbies | hobbies |
    And add body from json file update.json changing data
      | hobbies | {STORAGE}varHobbies |
    When send a patch to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}hobbies |
      | [0].message | {STRING}The max size os hobbies list is 3 |
