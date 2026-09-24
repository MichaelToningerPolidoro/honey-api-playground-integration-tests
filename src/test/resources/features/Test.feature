#language: en
@testingConfiguration
Feature: Testing configuration

  Scenario Outline: Testing configuration scenario 1
    Given add body from json file <data>

    Examples:
      | data      |
      | Test.json |

  # TODO: Scenarios wrong data

  # - login
    #  - try to login with non existent user
    #  - try to login with wrong password

  # - update
    # try to update to an nickname that already exists
    # try to update to an e-mail that is already registered
    # try to update an invalid token
    # try to update an invalid e-mail
    # try to update an invalid nickname
    # - try to use non existent hobby
    # - try to use non existent programming time experiênce
    # - try to use non existent country
