class Chat < ApplicationRecord
  has_many :messages
  belongs_to :user

  before_save :update_status

  private

  def update_status
    self.status = false
    self.status = messages.last.user != user if messages.last
  end
end
