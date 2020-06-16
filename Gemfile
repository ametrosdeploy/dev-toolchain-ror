# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'strip_attributes'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2'
# Postgres ...
gem 'pg', '~> 1.2.3'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
gem 'fast_jsonapi'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Authentication and Authorization gems ...
gem 'devise'
gem 'devise-jwt'
gem 'pundit'
gem 'rest-client'
gem 'rolify'

# For API doc
gem 'swagger-docs'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource
# Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Pagination Gem
gem 'will_paginate', '~> 3.3.0'

# To fetch ENV variables from .env file
gem 'dotenv-rails', require: 'dotenv/rails-now'

# Implement tagging feature on documents
gem 'acts-as-taggable-on', '~> 6.0'

# Ibm Watson Sdk
gem 'httparty'
gem 'ibm_watson'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Write test cases
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails', '~> 3.6'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running
  # in the background. Read more: https://github.com/rails/spring
  gem 'annotate'
  gem 'bullet'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Active storage base_64 image upload support
gem 'active_storage_base64'
