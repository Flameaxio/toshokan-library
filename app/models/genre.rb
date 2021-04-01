class Genre < ApplicationRecord
  has_many :book_genre_relationships
  has_many :books, through: :book_genre_relationships

  before_create :slugify

  private

  def slugify
    self.slug = name.parameterize
  end
end
