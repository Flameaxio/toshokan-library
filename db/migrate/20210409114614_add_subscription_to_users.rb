class AddSubscriptionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :users, :subscription
  end
end
