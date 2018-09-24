class JsonSerializer::Rentals < JsonSerializer::Base
  require_relative "rental"

  def as_json
    {
      rentals: @object.map { |o| JsonSerializer::Rental.new(o).as_json }
    }
  end
end
