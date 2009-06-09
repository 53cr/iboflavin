require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^a user is logged in$/ do
  Given "I am on the homepage"
  When 'I follow "Sign Up"'
  When 'I fill in "Username" with "Ryan"'
  When 'I fill in "Email" with "ryan@iboflav.in"'
  When 'I fill in "Password" with "iboflavin"'
  When 'I fill in "user_password_confirmation" with "iboflavin"'
  When 'I press "Register"'
  Then 'I should see "Login successful!"'
end
