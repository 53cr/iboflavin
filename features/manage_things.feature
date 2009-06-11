Feature: Manage things
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new thing
    Given I am on the new thing page
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "name 1"

  Scenario: Delete thing
    Given the following things:
      |name|
      |name 1|
      |name 2|
      |name 3|
      |name 4|
    When I delete the 3rd thing
    Then I should see the following things:
      |name|
      |name 1|
      |name 2|
      |name 4|
