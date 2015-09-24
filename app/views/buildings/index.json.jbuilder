json.array!(@buildings) do |building|
  json.extract! building, :id, :street_address, :street_address_2, :street_address3, :city, :state, :postal_code, :country
  json.url building_url(building, format: :json)
end
