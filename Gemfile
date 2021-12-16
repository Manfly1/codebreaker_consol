# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'codebreker_manfly', '~> 0.1.2'
gem 'i18n'

group :development, :test do
  gem 'faker'
  gem 'fasterer', '~> 0.8.3', require: false
  gem 'ffaker'
  gem 'lefthook', '~> 0.7.2', require: false
  gem 'pry-byebug'
  gem 'rspec', '~> 3.2'
  gem 'rubocop'
end

group :test do
  gem 'simplecov', '~> 0.18.5', require: false
end
