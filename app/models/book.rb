class Book < ApplicationRecord
  has_many :genres, through: BookGenreRelationship
  has_many :authors, through: BookAuthorRelationship
end
