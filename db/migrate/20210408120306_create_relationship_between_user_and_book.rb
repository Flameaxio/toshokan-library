class CreateRelationshipBetweenUserAndBook < ActiveRecord::Migration[6.1]
  def change
    create_table :book_ownerships do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
