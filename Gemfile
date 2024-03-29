source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0'
  gem 'brakeman', require: false
  gem 'pry-rails'
  gem "capistrano"
  gem "capistrano-rbenv"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano3-unicorn"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
  gem 'bullet'
  gem 'rails_best_practices', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
  gem 'factory_bot_rails'
  gem 'database_rewinder'
  gem 'launchy'
  gem 'faker'
  gem 'rubocop-faker'
end

group :production do
  gem "unicorn", "5.4.1"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'cells-rails'
gem 'cells-erb'

gem 'rails-i18n'

gem 'jp_prefecture'
gem 'geocoder'

gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'devise', git: "https://github.com/heartcombo/devise.git",  branch: "ca-omniauth-2"

gem 'gon'
gem 'dotenv-rails'

gem 'activerecord-import'

gem 'kaminari'

gem 'aws-sdk-s3', require: false
