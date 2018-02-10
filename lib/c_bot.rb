# frozen_string_literal: true

require 'discordrb'
require 'configatron'
require 'rmagick'
require 'open-uri'
require 'tempfile'
require 'securerandom'
require_relative 'config.rb'

module CornBot
  include Magick

  WATERMARK = ImageList.new('data/images/ifunny_watermark.png')
  WATERMARK.fuzz = '20%'

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

  # Add event to automatically detect and crop out iFunny watermarks
  BOT.message do |event|
    next if event.from_bot?
    next unless event.message.attachments
    original_images = ImageList.new
    event.message.attachments.each do |attachment|
      original_images << Image.from_blob(open(attachment.url).read).first if attachment.image?
      original_images.each do |img|
        img.fuzz = '20%'
        next unless img.find_similar_region(WATERMARK, img.columns - 140, img.rows - 20)
        cropped = img.crop(0, 0, img.columns, img.rows - 20, true)
        temp_img = Tempfile.new([SecureRandom.uuid, '.jpg'])
        cropped.write(temp_img.path)
        event << event.attach_file(temp_img.binmode)
      end
    end
  end

  BOT.run
end
