class Book < ApplicationRecord
  has_many :book_genre_relationships
  has_many :book_author_relationships
  has_many :genres, through: :book_genre_relationships
  has_many :authors, through: :book_author_relationships
end
