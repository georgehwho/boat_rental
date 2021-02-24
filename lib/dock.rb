class Dock
  attr_reader :name,
              :max_rental_time,
              :rental_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    total = {}
    total[:card_number] = renter_credit_card(boat)
    total[:amount] = charge_amount(boat)
    total
  end

  def renter_credit_card(boat)
    rental_log[boat].credit_card_number
  end

  def charge_amount(boat)
    return max_charge_amount(boat) if max_rental_time?(boat)
    boat.total_charge
  end

  def max_charge_amount(boat)
    max_rental_time * boat.price_per_hour
  end

  def max_rental_time?(boat)
    boat.hours_rented >= max_rental_time
  end
end
