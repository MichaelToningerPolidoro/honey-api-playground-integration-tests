@regression @invalidData @invalidDataRegister @register
Feature: invalid data register service

  @registerWithExistingEmail
  Scenario: Try to register a user with an email that is already registered
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerExistingEmailFirst       |
      | email    | register-existing-email@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file register.json changing data
      | nickName | registerExistingEmailSecond      |
      | email    | register-existing-email@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}email                           |
      | [0].message | {STRING}This data is already in use ... |

  @registerWithExistingNickname
  Scenario: Try to register a user with a nickname that is already registered
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerExistingNickname                  |
      | email    | register-existing-nickname-first@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file register.json changing data
      | nickName | registerExistingNickname                   |
      | email    | register-existing-nickname-second@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}nickName                        |
      | [0].message | {STRING}This data is already in use ... |

  @registerWithNonExistentHobby
  Scenario: Try to register a user with a non existent hobby
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName   | registerNonExistentHobby             |
      | email      | register-non-existent-hobby@test.com |
      | hobbies[0] | Non existent hobby                   |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | message | {STRING}Some hobby is invalid or duplicated! Please check the resource below to see all available options |

  @registerWithNonExistentProgrammingTime
  Scenario: Try to register a user with a non existent programming time experience
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName        | NonExistentProgrammingTime             |
      | email           | non-existent-programming-time@test.com |
      | programmingTime | Non existent programming time          |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | message | {STRING}The programming time option is invalid! Please check the resource below to see all available options |

  @registerWithNonExistentCountry
  Scenario: Try to register a user with a non existent country
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName         | registerNonExistentCountry             |
      | email            | register-non-existent-country@test.com |
      | bornData.country | Non existent country                   |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | message           | {STRING}The country is invalid! Please check the resource below to see all available options |
      | resource.method   | {STRING}GET                                                                                  |
      | resource.endpoint | {STRING}/v1/countries                                                                        |

  @registerWithFutureBirthdate
  Scenario: Try to register a user with a birthdate later than today
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName      | registerFutureBirthdate            |
      | email         | register-future-birthdate@test.com |
      | bornData.date | 2999-12-31                         |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData.date                                                                          |
      | [0].message | {STRING}The date is not valid. It must be in pattern yyyy-mm-dd and it needs to be in the past |

  @registerWithInvalidEmail
  Scenario: Try to register a user with an invalid email format
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerInvalidEmail   |
      | email    | register-invalid-email |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}email                       |
      | [0].message | {STRING}The email needs to be valid |

  @registerWithInvalidPassword
  Scenario: Try to register a user with an invalid password format
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerInvalidPassword            |
      | email    | register-invalid-password@test.com |
      | password | password with spaces               |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field | {STRING}password |

  @registerWithLongNickname
  Scenario: Try to register a user with a nickname longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerNicknameMoreThanThirtyTwoCharacters |
      | email    | register-long-nickname@test.com             |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}nickName                               |
      | [0].message | {STRING}The character limit for nickName is 32 |

  @registerWithLongEmail
  Scenario: Try to register a user with an email longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerLongEmail                                                        |
      | email    | register-email-with-more-than-sixty-four-characters-for-testing@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}email                               |
      | [0].message | {STRING}The character limit for email is 64 |

  @registerWithBlankNickname
  Scenario: Try to register a user with a blank nickname
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | {NULL}                           |
      | email    | register-blank-nickname@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}nickName                             |
      | [0].message | {STRING}The nickName cannot be null or blank |

  @registerWithInvalidNicknamePattern
  Scenario: Try to register a user with an invalid nickname format
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | 123 invalid nickname               |
      | email    | register-invalid-nickname@test.com |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}nickName                                                                      |
      | [0].message | {STRING}The nickname must start with a letter and cannot contain spaces, only numbers |

  @registerWithBlankName
  Scenario: Try to register a user with a blank name
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerBlankName            |
      | email    | register-blank-name@test.com |
      | name     | {NULL}                       |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}name                             |
      | [0].message | {STRING}The name cannot be null or blank |

  @registerWithLongName
  Scenario: Try to register a user with a name longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerLongName                                                      |
      | email    | register-long-name@test.com                                           |
      | name     | ThisNameHasMoreThanSixtyFourCharactersAndShouldBeRejectedByValidation |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}name                               |
      | [0].message | {STRING}The character limit for name is 64 |

  @registerWithInvalidNamePattern
  Scenario: Try to register a user with an invalid name format
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerInvalidName            |
      | email    | register-invalid-name@test.com |
      | name     | Joaquim123                     |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}name                                        |
      | [0].message | {STRING}The name can only contain letters and space |

  @registerWithBlankEmail
  Scenario: Try to register a user with a blank email
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerBlankEmail |
      | email    | {NULL}             |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}email                             |
      | [0].message | {STRING}The email cannot be null or blank |

  @registerWithBlankPassword
  Scenario: Try to register a user with a blank password
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerBlankPassword            |
      | email    | register-blank-password@test.com |
      | password | {NULL}                           |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}password                             |
      | [0].message | {STRING}The password cannot be null or blank |

  @registerWithLongPassword
  Scenario: Try to register a user with a password longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerLongPassword                                              |
      | email    | register-long-password@test.com                                   |
      | password | ThisPasswordHasMoreThanSixtyFourCharactersAndShouldFailValidation |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}password                               |
      | [0].message | {STRING}The character limit for password is 64 |

  @registerWithBlankProgrammingTime
  Scenario: Try to register a user with a blank programming time
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName        | registerBlankProgrammingTime             |
      | email           | register-blank-programming-time@test.com |
      | programmingTime | {BLANK_STRING}                           |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}programmingTime                             |
      | [0].message | {STRING}The programmingTime cannot be null or blank |

  @registerWithLongProgrammingTime
  Scenario: Try to register a user with a programming time longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName        | registerLongProgrammingTime                                                                                                                                                                                                                                          |
      | email           | register-long-programming-time@test.com                                                                                                                                                                                                                              |
      | programmingTime | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}programmingTime                                |
      | [0].message | {STRING}The character limit for programmingTime is 256 |

  @registerWithNullBornData
  Scenario: Try to register a user with null born data
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerNullBornData             |
      | email    | register-null-born-data@test.com |
      | bornData | {NULL}                           |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData                    |
      | [0].message | {STRING}The bornData cannot be null |

  @registerWithBlankBirthdate
  Scenario: Try to register a user with a blank birthdate
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName      | registerBlankBirthdate            |
      | email         | register-blank-birthdate@test.com |
      | bornData.date | {BLANK_STRING}                    |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field | {STRING}bornData.date |

  @registerWithInvalidBirthdateFormat
  Scenario: Try to register a user with an invalid birthdate format
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName      | registerWrongBirthdateFormat             |
      | email         | register-wrong-birthdate-format@test.com |
      | bornData.date | 123x-12-31                               |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData.date                                                                          |
      | [0].message | {STRING}The date is not valid. It must be in pattern yyyy-mm-dd and it needs to be in the past |

  @registerWithLongBirthdate
  Scenario: Try to register a user with an long birthdate
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName      | registerLongBirthdate            |
      | email         | register-long-birthdate@test.com |
      | bornData.date | 1234-11-010                      |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | any {it.field == 'bornData.date'}                        | {BOOLEAN}true |
      | any {it.message == 'The character limit for date is 10'} | {BOOLEAN}true |

  @registerWithFutureBirthdate
  Scenario: Try to register a user with an future birthdate
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName      | registerLongBirthdate            |
      | email         | register-long-birthdate@test.com |
      | bornData.date | 9999-12-31                       |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData.date                                                                          |
      | [0].message | {STRING}The date is not valid. It must be in pattern yyyy-mm-dd and it needs to be in the past |

  @registerWithBlankCountry
  Scenario: Try to register a user with a blank country
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName         | registerBlankCountry            |
      | email            | register-blank-country@test.com |
      | bornData.country | {BLANK_STRING}                  |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData.country                    |
      | [0].message | {STRING}The country cannot be null or blank |

  @registerWithLongCountry
  Scenario: Try to register a user with a country longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName         | registerLongCountry                                              |
      | email            | register-long-country@test.com                                   |
      | bornData.country | This country name has more than forty-eight characters and fails |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}bornData.country                      |
      | [0].message | {STRING}The character limit for country is 48 |

  @registerWithEmptyHobbies
  Scenario: Try to register a user without hobbies
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | registerEmptyHobbies            |
      | email    | register-empty-hobbies@test.com |
      | hobbies  | {EMPTY_LIST}                    |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}hobbies                             |
      | [0].message | {STRING}The hobbies cannot be null or empty |

  @registerWithMoreThanThreeHobbies
  Scenario: Try to register a user with more than three hobbies
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    When send a get to http://localhost:8080/v1/hobbies
    Then validate response status equals 200
    And save response data
      | varHobbies | hobbies |
    And add body from json file register.json changing data
      | nickName | registerMoreThanThreeHobbies          |
      | email    | registerMoreThanThreeHobbies@test.com |
      | hobbies  | {STORAGE}varHobbies                   |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}hobbies                           |
      | [0].message | {STRING}The max size os hobbies list is 3 |
