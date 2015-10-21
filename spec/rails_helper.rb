ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end
require "spec_helper"
require "support/features"
require "rspec/rails"
require "capybara/rspec"
require "capybara/rails"
require "simplecov"
SimpleCov.start "rails"
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.backtrace_exclusion_patterns << %r{/gems/}
end
