class User < ApplicationRecord
  has_secure_password

  has_many :book_ownerships
  has_many :books, through: :book_ownerships

  validates_presence_of :email
  validates_uniqueness_of :email

end
