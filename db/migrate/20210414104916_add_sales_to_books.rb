class AddSalesToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :sales, :integer, default: 0
  end
end
