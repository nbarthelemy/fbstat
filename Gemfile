source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '~> 4.0.2'
gem 'figaro'

gem 'pg'

# Assets
gem 'jquery-rails'
gem 'jquery-rails-cdn'
gem 'twitter-bootstrap-rails-cdn'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'debugger'
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller' # for better_errors
end

group :development, :test do
  gem 'rspec-rails'
  gem 'brakeman' # for security scanning
  gem 'rails_best_practices'
end

group :test do
  gem 'shoulda-matchers'
  gem 'fabrication'
  gem 'ffaker'
  gem 'database_cleaner'
  gem 'simplecov', require: false
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor' # only for heroku
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end