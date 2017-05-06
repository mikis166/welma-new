class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  after_create_commit :prepare_for_broadcast

  def prepare_for_broadcast
    conv = self.conversation

    if conv.recipient.presence == "offline"
      conv.recipient_offline
    elsif conv.sender == "offline"
      conv.sender_offline
    end

    recipient = conv.recipient_id
    sender = conv.sender_id

    user = self.user_id == sender ? recipient : sender
    conv.new_messages_available_for.push(user) if !conv.new_messages_available_for.include?(user.to_s)
    conv.save

    MessageBroadcastJob.perform_later(self)
  end
end
