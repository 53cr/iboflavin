# https://www.pivotaltracker.com/story/show/754406
Feature: Plural Recognition
  In order to have users feel the system is more human
  Users will need to see their foods pluralized properly

  Scenario: User inputs a non-plural as plural
    Given a user is logged in
    And on the homepage
    When the user enters "Some eggs"
    Then the user should see "One serving of egg"
    # Not the best example

  Scenario: User inputs a plural as non-plural
    Given a user is logged in
    And on the homepage
    When the user enters "fifty grape"
    Then the user should see "Fifty grapes"
    # Also not the best example
  
