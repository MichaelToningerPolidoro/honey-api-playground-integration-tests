#language: en

@regression @referenceData
Feature: Reference data

  Scenario: Retrieve available countries
    Given add authorization header
    When send a get to http://localhost:8080/v1/countries
    Then validate response status equals 200
    And validate response body
      | countries.size() > 0 | {BOOLEAN}true |

  Scenario: Retrieve available hobbies
    Given add authorization header
    When send a get to http://localhost:8080/v1/hobbies
    Then validate response status equals 200
    And validate response body
      | hobbies.size() > 0 | {BOOLEAN}true |

  Scenario: Retrieve available programming time options
    Given add authorization header
    When send a get to http://localhost:8080/v1/programming-time-options
    Then validate response status equals 200
    And validate response body
      | programmingTimeOptions.size() > 0 | {BOOLEAN}true |
