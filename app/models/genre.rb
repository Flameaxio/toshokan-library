class Genre < ApplicationRecord
  has_many :book_genre_relationships
  has_many :books, through: :book_genre_relationships
end
