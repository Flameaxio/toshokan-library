class BookGenreRelationship < ApplicationRecord
  belongs_to :book
  belongs_to :genre

  def book
    Book.where(id: book_id).first
  end

  def genre
    Genre.where(id: genre_id).first
  end
end
