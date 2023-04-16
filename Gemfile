source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "interactor", "~> 3.0"
gem "bcrypt"
gem "redis"
gem "sidekiq"
gem "jwt"
gem "kaminari"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
	gem "pry-rails"
	gem "rspec-rails"
	gem "rspec-json_expectations"
	gem "factory_bot_rails"
	gem "faker"
	gem "timecop"
end

group :test do
	gem 'shoulda-matchers'
	gem 'database_cleaner'
end

group :development do
  
end

