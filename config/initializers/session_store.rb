# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_iboflavin_session',
  :secret      => '2adcb174c6f0c586d107a56f6f1570c71070d5f92e16c82e707e05800b91ce63ca0a9cc3a685c087b498f91b42d668162d054a712ae8fc7cf212a9fbcf7efd7e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
