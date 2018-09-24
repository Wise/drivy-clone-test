class Rental < Model
  attr_reader :id, :car, :start_date, :end_date, :distance, :price

  def initialize(attrs = {})
    super attrs
    initialize_dynamic_attributes
  end

  def duration_in_days
    (@end_date - @start_date).to_i + 1
  end

  private

  attr_writer :id, :car, :start_date, :end_date, :distance, :price

  def initialize_dynamic_attributes
    time_price = @car.price_per_day * self.duration_in_days
    distance_price = @car.price_per_km * self.distance
    @price = time_price + distance_price
  end

  # attributes setters
  def start_date=(v)
    @start_date = Date.parse(v)
  end

  def end_date=(v)
    @end_date = Date.parse(v)
  end
end
