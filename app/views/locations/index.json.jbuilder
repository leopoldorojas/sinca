json.array!(@locations) do |location|
  json.extract! location, :id, :code, :name, :type, :parent_id
  json.url location_url(location, format: :json)
end
