require 'simplecov'
require 'simplecov-lcov'
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov::Formatter::LcovFormatter.config do |c|
  c.single_report_path = 'coverage/lcov.info'
end
SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::LcovFormatter,
  ],
)
SimpleCov.start

# Boot rails dummy application
ENV['RAILS_ENV'] = 'test'
require_relative './dummy/config/environment'
ActiveRecord::Migrator.migrations_paths = [File.expand_path('./dummy/db/migrate', __dir__)]
# require 'rails/test_help'
require 'rspec/rails'

# Load in engine
require 'rapils'

# Load all support files
Dir["#{__dir__}/support/**/*.rb"].sort.each { |f| require f }

# Factories/Fixtures
require 'factory_bot'
FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # config.disable_monkey_patching!

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 3

  config.order = :random
  Kernel.srand config.seed

  # Rails specifics
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
