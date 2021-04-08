class BooksByGenreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug
  attribute :books do |object|
    books = []
    BookGenreRelationship.where(genre_id: object.id).map do |relation|
      books << Book.where(id: relation.book_id)&.first
    end
    BookSerializer.new(books).as_json
  end
end