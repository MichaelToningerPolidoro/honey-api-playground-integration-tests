#language: en

@regression
Feature: Testing configuration

  Scenario Outline: Testing configuration scenario 1
    Given add body from json file <data>

    Examples:
      | data      |
      | Test.json |
      | Test.json |
      | Test.json |
      | Test.json |
      | Test.json |
      | Test.json |
      | Test.json |
      | Test.json |
      | Test.json |
      | Test.json |
      | Test.json |
      | Test.json |

  # TODO: Scenarios searching data
  #  - search countries (more than 0 values, not empty .. )
  #  - search hobbies (more than 0 values, not empty .. )
  #  - search programming time experience (more than 0 values, not empty .. )

  # TODO: Scenarios end to end
  # - register
  # - login
  # - update data
  # - get data
  # - delete user
  # - get data (404)

  # TODO: Scenarios wrong data
  # - register
    # - try to register same e-mail 2 times
    # - try to register same nickname 2 times
    # - try to use non existent hobby
    # - try to use non existent programming time experiênce
    # - try to use non existent country
    # - try to use birthdate more than today
    # - try to use invalid e-mail format
    # - try to use invalid password format

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

  # get
    # try to get non existent user (invalid token)
    # try to get a user that is already deleted (create, login, save token, delete try to get)

  # delete
    # delete non existent user
    # try to delete invalid token
  