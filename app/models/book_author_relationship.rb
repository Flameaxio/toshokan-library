class BookAuthorRelationship < ApplicationRecord
  belongs_to :author
  belongs_to :book

  def book
    Book.where(id: book_id).first
  end

  def author
    Author.where(id: author_id).first
  end
end
