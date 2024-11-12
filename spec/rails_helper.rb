require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'devise'
require 'database_cleaner/active_record'

Rails.root.glob('spec/support/**/*.rb').each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Factory Bot
  config.include FactoryBot::Syntax::Methods

  # Devise
  config.include Devise::Test::IntegrationHelpers
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
