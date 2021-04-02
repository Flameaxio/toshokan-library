class BookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :image_url, :slug

  attribute :genres do |object|
    object.genres.as_json
  end

  attribute :authors do |object|
    object.authors.as_json
  end
end
