# frozen_string_literal: true

require 'database_cleaner'
# require 'paperclip/matchers'
# require 'paper_trail/frameworks/rspec'
# require_relative '../lib/simplecov_hcw_profile'

if ENV['SUPER_DIFF_ENABLED'] == 'true'
  require 'super_diff/rspec'
  require 'super_diff/active_support'
end

Knapsack::Adapters::RSpecAdapter.bind if ENV['KNAPSACK_ENABLED'] == 'true'

if ENV['SIMPLE_COV_ENABLED'] == 'true'
  simplecov_dir = File.join('test_results', 'coverage')
  SimpleCov.coverage_dir(simplecov_dir)

  SimpleCov.start 'simplecov_hcw_profile' do
    maximum_coverage_drop 10 # = allow 10% coverage drop for now... can adjust later
  end
end

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'
require 'rspec/json_expectations'
require 'rspec/support'
# require 'aasm/rspec'
# require './spec/deprecation_toolkit_env'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec::Expectations.configuration.warn_about_potential_false_positives = false

RSpec.configure do |config|
  config.fixture_path = "#{Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.include FactoryBot::Syntax::Methods
  # config.include Paperclip::Shoulda::Matchers
  # config.include ActiveSupport::Testing::TimeHelpers
  # config.include BasicAuthHelper, type: :controller
  # config.include BasicAuthRequestHelper, type: :request
  # config.include VCRHelper

  # config.before(:each) { Platform::ErrorReporting::Backends::Memory.clear! }

  # config.define_derived_metadata do |meta|
  #   if meta[:aggregate_failures].nil? && meta[:file_path].starts_with?('./spec/components/payroll/')
  #     meta[:aggregate_failures] = true
  #   end

  #   if meta[:aggregate_failures].nil? && meta[:file_path].starts_with?('./spec/components/core_banking/')
  #     meta[:aggregate_failures] = true
  #   end
  # end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.order = 'random'

  config.before(:each) do
    ActionMailer::Base.deliveries.clear

    Rails.cache.clear
  end

  config.after(:each) do
    Timecop.return
    # travel_back
  end

  VALID_BASE_64_IMAGE_STRING = 'R0lGOD' # rubocop:todo Lint/ConstantDefinitionInBlock

  config.mock_with :rspec do |mocks|
    # In RSpec 3, any_instance implementation blocks will be yielded the receiving
    # instance as the first block argument to allow the implementation block to use
    # the state of the receiver.
    # In RSpec 2.99, to maintain compatibility with RSpec 3 you need to either set
    # this config option to false OR set this to true and update your
    # any_instance implementation blocks to account for the first block argument
    # being the receiving instance.
    mocks.yield_receiver_to_any_instance_implementation_blocks = true

    # When using verifying doubles, RSpec will check that the methods being stubbed
    # are actually present on the underlying object if it is available.
    mocks.verify_doubled_constant_names = true
  end

  # rspec-rails 3 will no longer automatically infer an example group's spec type
  # from the file location. You can explicitly opt-in to the feature using this
  # config option.
  # To explicitly tag specs without using automatic inference, set the :type
  # metadata manually:
  #
  #     describe ThingsController, :type => :controller do
  #       # Equivalent to being in spec/controllers
  #     end
  config.infer_spec_type_from_file_location!

end

# RSpec::Sidekiq.configure do |config|
#   config.warn_when_jobs_not_processed_by_sidekiq = false
# end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end