class Author < ApplicationRecord
  has_many :book_author_relationships
  has_many :books, through: :book_author_relationships
end
