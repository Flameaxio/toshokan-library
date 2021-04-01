class AuthorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug

  has_many :books
end
