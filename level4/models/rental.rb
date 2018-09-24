class Rental < Model
  attr_reader :id, :car, :start_date, :end_date, :distance, :price, :insurance_fee,
    :assistance_fee, :drivy_fee, :actions

  def initialize(attrs = {})
    super attrs
    initialize_dynamic_attributes
    initialize_actions
  end

  def duration_in_days
    (@end_date - @start_date).to_i + 1
  end

  private

  attr_writer :id, :car, :start_date, :end_date, :distance, :price, :insurance_fee,
    :assistance_fee, :drivy_fee, :actions

  def initialize_dynamic_attributes
    time_price = 0
    if self.duration_in_days > 10
      time_price = (@car.price_per_day * 10) +
        (self.duration_in_days - 10) * (@car.price_per_day * 50 / 100)
    elsif self.duration_in_days > 4
      time_price = (@car.price_per_day * 4) +
        (self.duration_in_days - 4) * (@car.price_per_day * 70 / 100)
    elsif self.duration_in_days > 1
      time_price = @car.price_per_day +
        (self.duration_in_days - 1) * (@car.price_per_day * 90 / 100)
    else
      time_price = @car.price_per_day * self.duration_in_days
    end
    distance_price = @car.price_per_km * self.distance
    @price = time_price + distance_price

    commission = @price * 30 / 100
    @insurance_fee = commission / 2
    @assistance_fee = self.duration_in_days * 100
    @drivy_fee = commission - @insurance_fee - @assistance_fee
  end

  def initialize_actions
    @actions = []
    @actions << Action.new(recipient: :driver, amount: @price)
    @actions << Action.new(recipient: :owner, amount: @price * 70 / 100)
    @actions << Action.new(recipient: :insurance, amount: @insurance_fee)
    @actions << Action.new(recipient: :assistance, amount: @assistance_fee)
    @actions << Action.new(recipient: :drivy, amount: @drivy_fee)
  end

  # attributes setters
  def start_date=(v)
    @start_date = Date.parse(v)
  end

  def end_date=(v)
    @end_date = Date.parse(v)
  end

  class Action
    attr_reader :who, :type, :amount

    def initialize(recipient:, amount:)
      send("#{recipient}_build", amount)
    end

    def driver_build(amount)
      @who = :driver
      @type = :debit
      @amount = amount
    end

    def owner_build(amount)
      @who = :owner
      @type = :credit
      @amount = amount
    end

    def insurance_build(amount)
      @who = :insurance
      @type = :credit
      @amount = amount
    end

    def assistance_build(amount)
      @who = :assistance
      @type = :credit
      @amount = amount
    end

    def drivy_build(amount)
      @who = :drivy
      @type = :credit
      @amount = amount
    end
  end
end
