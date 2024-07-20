class FavoriteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :date, :type, :url
end
