ThinkingSphinx::Index.define :book, with: :active_record do
  # fields
  indexes name, sortable: true
  indexes book_genre_relationships.genre.name, as: :genre
  indexes book_author_relationships.author.name, as: :author
end
