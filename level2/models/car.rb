class Car < Model
  attr_reader :id, :price_per_day, :price_per_km

  private
  attr_writer :id, :price_per_day, :price_per_km
end
