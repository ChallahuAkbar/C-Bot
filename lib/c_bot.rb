# frozen_string_literal: true

require 'discordrb'
require 'configatron'
require_relative 'config.rb'

bot = Discordrb::Bot.new token: configatron.token,
                         client_id: '168123456789123456'

# Events section

# Adds event to kick any user who says uwu
bot.message(with_text: /\buwu\b/i) do |event|
  event.server.kick(event.author)
end

# Adds event to play "just beat my dick" audio clip
bot.message(starts_with: '~beatmydick') do |event|
  channel = event.user.voice_channel
  next unless channel
  bot.voice_connect(channel)

  voice_bot = event.voice
  voice_bot.play_file('data/beatmydick.mp3')

  voice_bot.destroy
end

bot.run
