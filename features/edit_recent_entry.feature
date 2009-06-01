# https://www.pivotaltracker.com/story/show/702061
Feature: Edit Recent Entries
  In order to correct recognition errors
  And keep customers happy
  Users will need to be able to modify recent entries

  Scenario: Editing Type of Food Just Entered

    Given a user is logged in
    And on the homepage
    When the user enters "42 Sultry Cramburgers"
    And clicks "edit"
    And fills "food" with "Hamburger"
    Then the user should see "42 Hamburgers"
  
  Scenario: Editing Quantity of Food Just Entered

  Scenario: Editing Quantity Units of Food Just Entered

  Scenario: Editing Food Entered One Day Ago
