# frozen_string_literal: true

require_relative '../lib/bootstrap'

require 'simplecov'
require 'fileutils'
require 'ffaker'

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
end

Dir["#{Dir.pwd}/lib/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.before(:each) do
    FileUtils.mkdir_p('store')
  end

  config.after(:each) { FileUtils.rm_rf('store') }

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

RSpec::Matchers.define :be_a_directory do
  match do |dir_path|
    Dir.exist?(dir_path)
  end
end
