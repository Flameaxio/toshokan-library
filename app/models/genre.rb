class Genre < ApplicationRecord
  has_many :books, through: BookGenreRelationship, dependent: delete(BookGenreRelationship.where(genre_id: id))
end
