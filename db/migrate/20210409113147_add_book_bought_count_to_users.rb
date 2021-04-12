class AddBookBoughtCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :books_bought, :integer, default: 0
  end
end
