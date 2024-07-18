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
