class Book < ApplicationRecord
  has_many :book_genre_relationships
  has_many :book_author_relationships
  has_many :genres, through: :book_genre_relationships
  has_many :authors, through: :book_author_relationships
  has_many :book_ownerships
  has_many :users, through: :book_ownerships

  before_create :slugify

  before_destroy :clear_pdf

  private

  def slugify
    self.slug = name.parameterize
  end

  def clear_pdf
    File.open("#{Rails.root}/public/pdfs/#{slug}.pdf", 'r') do |f|
      File.delete(f)
    end
  end
end
