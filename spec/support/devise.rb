RSpec.configure do |config|
# config for RSpec to work with Devise and Warden
  config.include Devise::Test::IntegrationHelpers
  config.include Warden::Test::Helpers

  config.before :suite do
    Warden.test_mode!
  end

  config.after do
    Warden.test_reset!
  end
end
