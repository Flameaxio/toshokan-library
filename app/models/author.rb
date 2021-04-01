class Author < ApplicationRecord
  has_many :books, through: BookAuthorRelationship, dependent: :delete_all
end
