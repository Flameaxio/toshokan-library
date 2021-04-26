class GenreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug

  has_many :books
end
