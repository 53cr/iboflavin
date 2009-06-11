# https://www.pivotaltracker.com/story/show/753703
Feature: Twitter Integration
  In order to simplify site use
  And attract additional customers
  Users will need to be able to tweet to iBoflavin

  Scenario: User Tweets a Food to iBoflavin
    When I tweet "200 g of Cucumber"
    And I am on my recently added entries page
    Then I should see "200 grams of Cucumber"  
  
