When /^I enter "([^\"]*)"$/ do |entry|
  fill_in('entry[input]', :with => entry)
  submit_form('new_entry')
end

Given /^I submitted "([^\"]*)" (\d+) days? ago$/ do |entry,days_ago|
  pending
end