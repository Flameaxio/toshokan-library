class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.integer :price
      t.integer :month_limit

      t.timestamps
    end
  end
end
