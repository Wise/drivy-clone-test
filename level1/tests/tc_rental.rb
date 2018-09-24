require "test/unit"
require "date"

class TestRental < Test::Unit::TestCase
  def setup
    @car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    @rental = Rental.new(id: 1, car: @car, start_date: "2017-12-8", end_date: "2017-12-10",
               distance: 100)
  end

  def test_new
    assert_equal(1, @rental.id)
    assert_equal(@car, @rental.car)
    assert_equal(Date.parse("2017-12-8"), @rental.start_date)
    assert_equal(Date.parse("2017-12-10"), @rental.end_date)
    assert_equal(100, @rental.distance)
  end

  def test_duration
    assert_equal(3, @rental.duration_in_days)
  end

  def test_price
    assert_equal(7000, @rental.price)
  end
end
