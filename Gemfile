# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Ruby bindings for Discord API
gem 'discordrb', github: 'meew0/discordrb'

# Configuration manager
gem 'configatron', '~> 4.5'

# ImageMagick interface
gem 'rmagick', '>= 4.1.0.rc2', '< 5'

group :development do
  # Code linting
  gem 'rubocop', '~> 0.80.0', require: false
  gem 'rubocop-performance', '~> 1.1', require: false

  # Documentation
  gem 'yard', '~> 0.9.20'

  # Language server
  gem 'solargraph', require: false

  # Better REPL
  gem 'pry', require: false
end
