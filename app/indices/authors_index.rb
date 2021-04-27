ThinkingSphinx::Index.define :author, with: :active_record do
  # fields
  indexes name, sortable: true
  indexes book_author_relationships.book.name, as: :book

end
