class Subscription < ApplicationRecord
  has_many :users

  composed_of :price,
              class_name: 'Money',
              mapping: %w[price cents],
              converter: proc { |value| Money.new(value) }
end
