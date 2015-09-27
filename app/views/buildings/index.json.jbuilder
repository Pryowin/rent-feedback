json.array!(@buildings) do |building|
  json.extract! building, :id, :building_number, :street_name, :street_address_2, :street_address_3, :city, :state, :postal_code, :country
  json.url building_url(building, format: :json)
end
