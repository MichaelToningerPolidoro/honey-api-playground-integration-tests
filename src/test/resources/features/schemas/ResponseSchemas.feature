#language: en

@regression @contract @schema
Feature: Response schemas

  Background:
    Given add authorization header
    And add headers
      | Content-Type | application/json |

  @loginResponseSchema
  Scenario: Validate the login response schema
    Given save data in storage
      | schemaLoginEmail    | {EMAIL}    |
      | schemaLoginNickname | {NICKNAME} |
    And add body from json file register.json changing data
      | nickName | {STORAGE}schemaLoginNickname |
      | email    | {STORAGE}schemaLoginEmail    |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file login.json changing data
      | email | {STORAGE}schemaLoginEmail |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And validate response body against schema "login-response-schema.json"

  @userResponseSchema
  Scenario: Validate the user response schema
    Given save data in storage
      | schemaUserEmail    | {EMAIL}    |
      | schemaUserNickname | {NICKNAME} |
    And add body from json file register.json changing data
      | nickName | {STORAGE}schemaUserNickname |
      | email    | {STORAGE}schemaUserEmail    |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 201

    Given add body from json file login.json changing data
      | email | {STORAGE}schemaUserEmail |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 200
    And save response data
      | schemaLoginToken | token |

    Given remove body
    And add headers
      | loginToken | {STORAGE}schemaLoginToken |
    When send a get to http://localhost:8080/v1/user
    Then validate response status equals 200
    And validate response body against schema "user-response-schema.json"

  @validationErrorSchema
  Scenario: Validate the validation error response schema
    Given add body from json file login.json changing data
      | email | {STRING}invalid-email |
    When send a post to http://localhost:8080/v1/login
    Then validate response status equals 400
    And validate response body against schema "validation-error-schema.json"

  @referenceDataResponseSchemas
  Scenario Outline: Validate the reference data response schema
    Given remove body
    When send a get to <endpoint>
    Then validate response status equals 200
    And validate response body against schema "<schema>"

    Examples:
      | endpoint                              | schema                                             |
      | http://localhost:8080/v1/countries     | countries-response-schema.json                     |
      | http://localhost:8080/v1/hobbies       | hobbies-response-schema.json                       |
      | http://localhost:8080/v1/programming-time-options | programming-time-options-response-schema.json |

  @messageErrorResponseSchema
  Scenario: Validate the message error response schema
    Given add headers
      | loginToken | invalid-login-token |
    When send a get to http://localhost:8080/v1/user
    Then validate response status equals 401
    And validate response body against schema "message-error-schema.json"

  @itemNotRegisteredErrorResponseSchema
  Scenario: Validate the item not registered error response schema
    Given add body from json file register.json changing data
      | nickName         | schemaInvalidCountry             |
      | email            | schema-invalid-country@test.com  |
      | bornData.country | Non existent country             |
    When send a post to http://localhost:8080/v1/user
    Then validate response status equals 400
    And validate response body against schema "item-not-registered-error-schema.json"
