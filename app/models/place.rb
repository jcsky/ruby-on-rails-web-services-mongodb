class Place
  attr_accessor :id, :formatted_address, :location, :address_components

  class << self
    def mongo_client; Mongoid::Clients.default; end
    def collection; self.mongo_client[:places]; end
    def load_all(json_file); self.collection.insert_many JSON.parse(json_file.read); end
  end


  def initialize(params)
    @id = params[:_id].to_s
    @formatted_address = params[:formatted_address]
    @location = Point.new params[:geometry][:geolocation]
    @address_components = params[:address_components].map {|c| AddressComponent.new(c)}
  end
end