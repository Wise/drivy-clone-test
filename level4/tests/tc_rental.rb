require "test/unit"
require "date"

class TestRental < Test::Unit::TestCase
  def setup
    @car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    @rental = Rental.new(id: 1, car: @car, start_date: "2017-12-8", end_date: "2017-12-8",
               distance: 100)
  end

  def test_new
    assert_equal(1, @rental.id)
    assert_equal(@car, @rental.car)
    assert_equal(Date.parse("2017-12-8"), @rental.start_date)
    assert_equal(Date.parse("2017-12-8"), @rental.end_date)
    assert_equal(100, @rental.distance)
  end

  def test_duration
    assert_equal(1, @rental.duration_in_days)
  end

  def test_normal_price
    assert_equal(3000, @rental.price)
  end

  def test_1_day_price
    @rental = Rental.new(id: 1, car: @car, start_date: "2017-12-8", end_date: "2017-12-9",
               distance: 100)
    assert_equal(4800, @rental.price)
  end

  def test_4_days_price
    @rental = Rental.new(id: 1, car: @car, start_date: "2017-12-8", end_date: "2017-12-12",
               distance: 100)
    assert_equal(10400, @rental.price)
  end

  def test_10_days_price
    @rental = Rental.new(id: 1, car: @car, start_date: "2017-12-8", end_date: "2017-12-18",
               distance: 100)
    assert_equal(22000, @rental.price)
  end

    def test_insurance_fee
      assert_equal(450, @rental.insurance_fee)
    end

    def test_assistance_fee
      assert_equal(100, @rental.assistance_fee)
    end

    def test_drivy_fee
      assert_equal(350, @rental.drivy_fee)
    end
end
