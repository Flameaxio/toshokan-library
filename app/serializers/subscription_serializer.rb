class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :month_limit
  attribute :price do |object|
    object.price.to_s
  end

  attribute :books_bought do |_object, params|
    params[:current_user]&.books_bought
  end

  attribute :active do |object, params|
    if params[:current_user]
      params[:current_user].subscription.id == object.id
    else
      false
    end
  end
end
