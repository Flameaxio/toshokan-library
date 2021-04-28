class Author < ApplicationRecord
  has_many :book_author_relationships
  has_many :books, through: :book_author_relationships

  before_create :slugify

  private

  def slugify
    self.slug = name.parameterize
  end
end
