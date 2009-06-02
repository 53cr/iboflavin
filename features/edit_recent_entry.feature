# https://www.pivotaltracker.com/story/show/702061
Feature: Edit Recent Entries
  In order to correct recognition errors
  And keep customers happy
  Users will need to be able to modify recent entries

  Scenario Outline: Editing Food Just Entered
    Given a user is logged in
    And on the homepage
    When the user enters "<entry>"
    And clicks "edit"
    And fills "<field>" with "<correction>"
    Then the user should see "<corrected>"

    Examples:
    | entry         | field  | correction | corrected             |
    | 42 Hamburgers | amount | 12         | 12 Hamburgers         |
    | 42 Hamburgers | unit   | grams      | 42 grams of Hamburger |
    | 42 Hamburgers | food   | Hotdogs    | 42 Hotdogs            |

  Scenario: Editing Food Entered One Day Ago
    Given a user is logged in
    And submitted " 42 Cramburgers" 1 day ago
    When the user clicks "edit"
    Then they should see "Editing"
