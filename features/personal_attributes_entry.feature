# https://www.pivotaltracker.com/story/show/705891
Feature: Personal Attributes Entry
  In order to enrich nutritional recommendations
  and provide more user specific output
  Users should be able to enter their personal attributes

  Scenario: Seeing my Profile
  Given I logged in
  When I go to the homepage
  And I follow "Profile"
  Then I should see "My Profile"
  And I should see the following:
  | attributes |
  | Login      |
  | Lifestyle |
  | Birthday |
  And I should be on the profile page
  
  
  Scenario: Editing my Profile
  Given I am visiting my profile
  When I follow "Edit"
  Then I should see "Edit My Profile"
  And I should be on the profile editing page
  
  Scenario: Changing my Profile
  # Fill me in