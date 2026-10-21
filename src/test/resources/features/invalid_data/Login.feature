@regression @invalidData @invalidDataLogin @login
Feature: invalid data login service

  @loginWithNonExistentUser
  Scenario: Try to login with a non existent user
    Given save data in storage
      | loginEmail | {EMAIL} |
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file login.json changing data
      | email | {STORAGE}loginEmail |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 404
    And validate response body
      | message | {STRING}User not found |

  @loginWithWrongPassword
  Scenario: Try to login with a wrong password
    Given save data in storage
      | loginEmail    | {EMAIL}    |
      | loginNickname | {NICKNAME} |
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file register.json changing data
      | nickName | {STORAGE}loginNickname |
      | email    | {STORAGE}loginEmail    |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file login.json changing data
      | email    | {STORAGE}loginEmail |
      | password | wrong-password |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 401
    And validate response body
      | message | {STRING}Invalid user credentials |

  @loginWithNullEmail
  Scenario: Try to login with a null email
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file login.json changing data
      | email | {NULL} |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}email |
      | [0].message | {STRING}The email cannot be null or blank |

  @loginWithNullPassword
  Scenario: Try to login with a null password
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file login.json changing data
      | email    | login-null-password@test.com |
      | password | {NULL} |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}password |
      | [0].message | {STRING}The password cannot be null or blank |

  @loginWithInvalidEmail
  Scenario: Try to login with an invalid email format
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file login.json changing data
      | email | login-invalid-email |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}email                       |
      | [0].message | {STRING}The email needs to be valid |

  @loginWithLongEmail
  Scenario: Try to login with an email longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file login.json changing data
      | email | login-email-with-more-than-sixty-four-characters-for-testing@test.com |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}email |
      | [0].message | {STRING}The character limit for email is 64 |

  @loginWithLongPassword
  Scenario: Try to login with a password longer than the allowed limit
    Given add authorization header
    And add headers
      | Content-Type | application/json |
    And add body from json file login.json changing data
      | email    | login-long-password@test.com |
      | password | This password has more than sixty-four characters and should fail validation |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 400
    And validate response body
      | [0].field   | {STRING}password |
      | [0].message | {STRING}The character limit for password is 64 |
