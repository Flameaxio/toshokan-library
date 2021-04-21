class AddDefaultSubscriptionToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :subscription_id, :integer, default: 1
  end
end
