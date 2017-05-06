# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ConversationChannel < ApplicationCable::Channel
  def subscribed
    puts "the #{current_user.id} is online"
    current_user.update(presence: "online") if current_user.presence == "offline"
    stream_from "conversations-#{current_user.id}"
  end

  def unsubscribed
    puts "the #{current_user.id} left"
    current_user.update(presence: "offline")
    stop_all_streams
  end

  def away
    puts "user is away"
  end

  def speak(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    Message.create(message_params)
  end
end
