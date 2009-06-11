Given /^I logged in$/ do
  Given "I am on the homepage"
  When 'I follow "Sign Up"'
  When 'I fill in "Username" with "Ryan"'
  When 'I fill in "Email" with "ryan@iboflav.in"'
  When 'I fill in "Password" with "iboflavin"'
  When 'I fill in "user_password_confirmation" with "iboflavin"'
  When 'I press "Register"'
  Then 'I should see "Login successful!"'
end

Given /^the user is not logged in$/ do
  pending
end

When /^fill in all the required fields$/ do
  pending
end

Then /^I should be shown a form to create an account$/ do
  pending
end


Then /^I should be logged in to my newly created account$/ do
  pending
end

When /^I fill in my username and password$/ do
  pending
end

Then /^I should be logged in$/ do
  pending
end

Then /^they should automatically be logged in$/ do
  pending
end

