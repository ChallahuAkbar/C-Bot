# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Ruby bindings for Discord API
gem 'discordrb', github: 'meew0/discordrb'

# Configuration manager
gem 'configatron', '~> 4.5'

# ImageMagick interface
gem 'rmagick', '~> 2.16'

group :development do
  # Code linting
  gem 'rubocop', '~> 0.61', require: false

  # Documentation
  gem 'yard', '~> 0.9.0'

  # Language server
  gem 'solargraph', '~> 0.29'
end
