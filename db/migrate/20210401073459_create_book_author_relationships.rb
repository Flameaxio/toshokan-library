class CreateBookAuthorRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :book_author_relationships do |t|
      t.belongs_to :author, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :book, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
