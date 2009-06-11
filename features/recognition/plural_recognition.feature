# https://www.pivotaltracker.com/story/show/754406
Feature: Plural Recognition
  In order to have users feel the system is more human
  Users will need to see their foods pluralized properly

  Scenario: User inputs a non-plural as plural
    Given I logged in
    And I am on the homepage
    When I enter "Some eggs"
    Then I should see "One serving of egg"
    # Not the best example

  Scenario: User inputs a plural as non-plural
    Given I logged in
    And I am on the homepage
    When I enter "fifty grape"
    Then I should see "Fifty grapes"
    # Also not the best example
  
