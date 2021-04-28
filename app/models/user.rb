class User < ApplicationRecord
  has_secure_password

  has_many :book_ownerships
  has_many :books, through: :book_ownerships
  has_many :messages
  has_one :chat
  belongs_to :subscription, optional: true

  validates_presence_of :email
  validates_uniqueness_of :email

  def check_limit
    books_bought < subscription.month_limit
  rescue NoMethodError
    false
  end

  def books_bought
    BookOwnership.where(user_id: id, created_at: Time.current.beginning_of_month..Time.current.end_of_month).count
  end
end
