Devise.setup do |config|
  # authentication system setup
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  
  require 'devise/orm/active_record'
  
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.sign_out_via = :delete

  config.navigational_formats = ['*/*', :html, :turbo_stream]



  config.authentication_keys = [:email]
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
end