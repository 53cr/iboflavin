# https://www.pivotaltracker.com/story/show/702061
Feature: Edit Recent Entries
  In order to correct recognition errors
  And keep customers happy
  Users will need to be able to modify recent entries

  Scenario Outline: Editing Food Just Entered
    Given I logged in
    And I am on the homepage
    When I enter "<entry>"
    And I press "edit"
    And I fill in "<field>" with "<correction>"
    Then I should see "<corrected>"

    Examples:
    | entry         | field  | correction | corrected             |
    | 42 Hamburgers | amount | 12         | 12 Hamburgers         |
    | 42 Hamburgers | unit   | grams      | 42 grams of Hamburger |
    | 42 Hamburgers | food   | Hotdogs    | 42 Hotdogs            |

  Scenario: Editing Food Entered One Day Ago
    Given I logged in
    And I submitted " 42 Cramburgers" 1 day ago
    When I follow "edit"
    Then I should see "Editing"
