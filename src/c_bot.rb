# frozen_string_literal: true

require 'discordrb'
require 'configatron'
require 'rmagick'
require 'open-uri'
require 'tempfile'
require 'securerandom'
require_relative '../config.rb'

# Top level module
module CornBot
  include Magick

  WATERMARK = ImageList.new('data/images/ifunny_watermark.png')
  WATERMARK.fuzz = 0.2

  HEAVY_CHECK_MARK = "\u2714"
  CROSS_MARK = "\u274c"

  BOT = Discordrb::Bot.new token: configatron.token

  # Events section

  # Adds event to kick any user who says the secret word
  BOT.message(with_text: /\bschadenfreude\b/i) do |event|
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
      next unless attachment.image?

      orig_image_file = URI.parse(attachment.url).open.read
      original_images << Image.from_blob(orig_image_file).first

      original_images.each do |img|
        img.fuzz = 0.2
        next unless img.find_similar_region(WATERMARK, img.columns - 140, img.rows - 20)

        cropped = img.crop(0, 0, img.columns, img.rows - 20, true)
        temp_img = Tempfile.new([SecureRandom.uuid, '.jpg'])
        cropped.write(temp_img.path)
        reply = event.send_file(temp_img.binmode, caption: "#{event.author.mention} I cropped out the iFunny watermark. React with the check mark to keep this version or with the x to delete it.")

        reply.react(HEAVY_CHECK_MARK)
        reply.react(CROSS_MARK)

        BOT.add_await(:"delete_#{reply.id}", Discordrb::Events::ReactionAddEvent) do |reaction|
          next unless reaction.message.id == reply.id
          next unless reaction.user == event.message.author

          event.message.delete if reaction.emoji.name == HEAVY_CHECK_MARK
          reply.delete if reaction.emoji.name == CROSS_MARK
        end
      end
    end
  end

  BOT.pm(from: 97265931012562944) do |event|
    BOT.servers.each_value do |server|
      server.default_channel(send_messages: true).send_message(event.content)
    end
  end

  BOT.run
end
