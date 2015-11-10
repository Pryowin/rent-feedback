require 'httparty'

class GoogleAddressValidation < ActiveModel::Validator

  include HTTParty

  STREET_NUMBER = 'street_number'
  STREET = 'route'
  CITY = "locality\", \"political"
  STATE = "administrative_area_level_1\", \"political"
  POSTAL_CODE = 'postal_code'
  INVALID_ADDRESS = 'Unable to find address'
  ADDR_COMP = 'address_components'
  ERROR_KEY = 'ERROR'

  base_uri 'https://maps.googleapis.com'


  def validate(record)
    return if record.skip_validation
    @building = record
    response = address_response(record.building_number,
                                record.street_name.strip,
                                record.city.strip,
                                record.state.strip,
                                record.postal_code.strip,
                                record.country.strip)
    if response.key?(ERROR_KEY)
      record.errors[:base] << response[ERROR_KEY]
    else
      record.latitude = @building.latitude
      record.longitude = @building.longitude
    end
  end

  def address_response(bnum,street,city,state,zip,country)
    @address_hash = Hash.new
    key = ENV["GOOGLE_API_KEY"]
    street_safe = make_url_safe(street)
    city_safe = make_url_safe(city)
    address="#{bnum},+#{street_safe},+#{city_safe},+#{state},+#{zip},+#{country}"
    url = "#{base_path}address=#{address}&key=#{key}"
    resource = self.class.get(url, verify: false)
    validated_address_components(resource)
    error_check(bnum,street,city,state,zip,country) if @address_hash["Error"].nil?
    @address_hash
  end

  private

  def base_path
    '/maps/api/geocode/json?'
  end

  def make_url_safe(p1)
    p1.gsub(' ','+')
  end

  def validated_address_components(resource)
    results = resource["results"]
    addr_comp= Hash[* results]
    if addr_comp.empty? || addr_comp[ADDR_COMP].nil?
      @address_hash[ERROR_KEY] = INVALID_ADDRESS
      return
    end
    find_lat_long(addr_comp)
    @address_hash = create_hash(addr_comp[ADDR_COMP])
    @types =  address_types(addr_comp[ADDR_COMP])
  end

  def address_types(components)
    ret_arr = Array.new
    components.each {|element| ret_arr << element["types"] }
    ret_arr
  end

  def create_hash(components)
    ret_hash = Hash.new
    components.each do |element|
      key = element["types"].to_s.gsub!('["','').gsub!('"]','')
      key == STATE ? name = 'short_name' : name = 'long_name'
      value = element[name]
      ret_hash[key] = value
    end
    ret_hash
  end

  def error_check(bnum,street,city,state,zip,country)
    error_text = ''
    error_text = "#{city} not found in #{state}." if (@address_hash[STATE] != state ||
                                                      @address_hash[CITY] != city)
    if error_text == ''
      error_text = "Zip #{zip} not valid for #{city}." if zip != @address_hash[POSTAL_CODE]
    end
    if error_text == ''
      error_text = "Building #{bnum} not found on #{street}." if bnum != '' && @address_hash[STREET_NUMBER].nil?
    end
    @address_hash[ERROR_KEY] = error_text unless error_text == ''
  end

  def find_lat_long(addr_comp)
    @building.latitude = addr_comp["geometry"]["location"]["lat"]
    @building.longitude = addr_comp["geometry"]["location"]["lng"]
  end

end
