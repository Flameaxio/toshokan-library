ThinkingSphinx::Index.define :genre, with: :active_record do
  # fields
  indexes name, sortable: true
  indexes book_genre_relationships.book.name, as: :book
end
