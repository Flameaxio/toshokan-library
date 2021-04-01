class GenreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug
end
