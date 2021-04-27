class AddSlugsToAuthorsAndGenres < ActiveRecord::Migration[6.1]
  def change
    add_column :genres, :slug, :string
    add_column :authors, :slug, :string
    add_index :genres, :slug
    add_index :authors, :slug
  end
end
