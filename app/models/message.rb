class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  after_save do
    chat.update_attribute(:updated_at, Time.now)
  end
end
