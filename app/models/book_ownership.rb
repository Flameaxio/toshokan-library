class BookOwnership < ApplicationRecord
  belongs_to :user
  belongs_to :book

  before_create :update_sales

  def update_sales
    book.sales += 1
    book.save
  end
end
