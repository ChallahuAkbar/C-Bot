# frozen_string_literal: true

require 'discordrb'
require 'configatron'
require_relative 'config.rb'

module CornBot
  BOT = Discordrb::Bot.new token: configatron.token,
                           client_id: '168123456789123456'

  # Events section

  # Adds event to kick any user who says uwu
  BOT.message(with_text: /\buwu\b/i) do |event|
    event.server.kick(event.author)
  end

  # Adds event to play "just beat my dick" audio clip
  BOT.message(content: '~beatmydick') do |event|
    channel = event.user.voice_channel
    next unless channel
    BOT.voice_connect(channel)

    voice_bot = event.voice
    voice_bot.play_file('data/beatmydick.mp3')

    voice_bot.destroy
  end

  # Adds event to play "arise chicken" audio clip
  BOT.message(content: '~arisechicken') do |event|
    channel = event.user.voice_channel
    next unless channel
    BOT.voice_connect(channel)

    voice_bot = event.voice
    voice_bot.play_file('data/arisechicken.mp3')

    voice_bot.destroy
  end

  # Adds event to play "Penn's stfu" audio clip
  BOT.message(content: '~stfu') do |event|
    channel = event.user.voice_channel
    next unless channel
    BOT.voice_connect(channel)

    voice_bot = event.voice
    voice_bot.play_file('data/stfu.mp3')

    voice_bot.destroy
  end

  # Adds event to play "Big Smoke moan" audio clip
  BOT.message(content: '~smokemoan') do |event|
    channel = event.user.voice_channel
    next unless channel
    BOT.voice_connect(channel)

    voice_bot = event.voice
    voice_bot.play_file('data/smokemoan.mp3')

    voice_bot.destroy
  end

  # Adds event to play "bird up" audio clip
  BOT.message(content: '~birdup') do |event|
    channel = event.user.voice_channel
    next unless channel
    BOT.voice_connect(channel)

    voice_bot = event.voice
    voice_bot.play_file('data/birdup.mp3')

    voice_bot.destroy
  end

  BOT.run
end
