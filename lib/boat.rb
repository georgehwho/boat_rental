class Boat
  attr_reader :type,
              :price_per_hour,
              :hours_rented,
              :rented

  def initialize(type, price_per_hour)
    @type = type
    @price_per_hour = price_per_hour
    @hours_rented = 0
    @rented = nil
  end

  def add_hour
    @hours_rented += 1
  end

  def total_charge
    hours_rented * price_per_hour
  end

  def check_out
    @rented = true
  end

  def check_in
    @rented = false
  end
end
