source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'draper', '~> 4.0', '>= 4.0.1'
gem 'figaro', '~> 1.2'
gem 'jbuilder', '~> 2.7'
gem 'pagy', '~> 3.10'
gem 'pg', '~> 0.18.4'
gem 'puma', '~> 4.1'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'annotate', '~> 2.6.5'
  gem 'bullet', '~> 6.1', '>= 6.1.3'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rails_best_practices', '~> 1.20'
  gem 'reek', '~> 6.0', '>= 6.0.3'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.2'
  gem 'rubocop-rails', '~> 2.9', '>= 2.9.1'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'faker', '~> 2.15', '>= 2.15.1'
  gem 'rspec-json_expectations', '~> 2.2'
  gem 'shoulda-matchers', '~> 4.5', '>= 4.5.1'
  gem 'simplecov', '~> 0.21.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
