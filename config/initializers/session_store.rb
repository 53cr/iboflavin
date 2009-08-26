# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_iboflavin_session',
  :secret      => '37131bc1a2771651c07f54e9ed04ea2156da859603b0c836946b77895cfb64000afcc7a1652f38b3f2b40e680eae4801093dffd9f44a1e05651f6b9aca33810d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
