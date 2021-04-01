class AuthorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug
end
