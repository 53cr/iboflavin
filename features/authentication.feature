Feature: Authentication
In order to provide personal nutritional information and diet tracking,
the user must be able to create an account and log in. The user will be
 allowed to register or log in with a Twitter account to make the process quicker
 and to save time later when they want to connect a Twitter account.

 Scenario: Creating an Account
   Given the user is not logged in
   When they click "Sign Up"
   And fill in all the required fields
   Then they should be logged in to their newly created account

 Scenario: Logging In
   Given the user is not logged in
   When they click "Log In"
   And fill in their username and password
   And click submit
   Then they should be logged in

 Scenario: Logging In with Twitter
   Given the user is not logged in
   And they have a Twitter account which is attached to an iBoflavin account
   And they are currently signed in to that Twitter account
   When they click "Log me in with Twitter"
   Then they should automatically be logged in

 Scenario: Creating an Account with Twitter
   Given the user is not logged in
   And they have a Twitter account which is not already attached to an iBoflavin account
   When they click "Log me in with Twitter"
   And click "Allow" on the security prompt Twitter shows them,
   Then they should be shown a form to create an account
   And it should have their Twitter Screen Name, email, and Time Zone prefilled.