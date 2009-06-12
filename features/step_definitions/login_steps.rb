Given /I have a pre-existing account/ do
  Given "I am on the homepage"
  When 'I follow "Sign Up"'
  When 'I fill in "Username" with "Ryan"'
  When 'I fill in "Email" with "ryan@iboflav.in"'
  When 'I fill in "Password" with "iboflavin"'
  When 'I fill in "user_password_confirmation" with "iboflavin"'
  When 'I press "Register"'
end
  
Given /^I logged in$/ do
  Given "I have a pre-existing account"
end

Given /^the user is not logged in$/ do
  Given "I have a pre-existing account"
  Given 'I follow "logout"'
end

When /^fill in all the required fields$/ do
  When 'I fill in "Username" with "Ryan"'
  When 'I fill in "Email" with "ryan@iboflav.in"'
  When 'I fill in "Password" with "iboflavin"'
  When 'I fill in "user_password_confirmation" with "iboflavin"'
end

Then /^I should be shown a form to create an account$/ do
  Then 'I should see "Sign Up"'
end

When /^I fill in my username and password$/ do
  When 'I fill in "Login" with "Ryan"'
  When 'I fill in "Password" with "iboflavin"'
end

Then /^they should automatically be logged in$/ do
  pending
end

