require "test/unit"

class TestCar < Test::Unit::TestCase
  def test_new
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    assert_equal(1, car.id)
    assert_equal(2000, car.price_per_day)
    assert_equal(10, car.price_per_km)
  end
end
