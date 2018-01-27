# frozen_string_literal: true

require 'discordrb'
require 'configatron'
require_relative 'config.rb'

bot = Discordrb::Bot.new token: configatron.token, client_id: 168123456789123456

bot.message(with_text: /\buwu\b/i) do |event|
  event.server.kick(event.author)
end
