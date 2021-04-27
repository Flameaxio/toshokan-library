class AddSlugToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :slug, :string
    add_index :books, :slug
  end
end
