require './lib/dock'
require './lib/renter'
require './lib/boat'
require "minitest/autorun"

class DockTest < Minitest::Test
  def test_it_exists
    dock = Dock.new("The Rowing Dock", 3)
    assert_instance_of Dock, dock
  end

  def test_it_has_attributes
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal "The Rowing Dock", dock.name
    assert_equal 3, dock.max_rental_time
    expected = {}
    assert_equal expected, dock.rental_log
  end

  def test_it_can_rent_out_boats
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    expected = {
      kayak_1 => patrick
    }

    assert_equal patrick, dock.rent(kayak_1, patrick)
    assert_equal expected, dock.rental_log
  end

  def test_iteration_2_test_suite
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal "The Rowing Dock", dock.name

    assert_equal 3, dock.max_rental_time

    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)

    expected = {
      kayak_1 => patrick,
      kayak_2 =>patrick,
      sup_1 => eugene
    }
    assert_equal expected, dock.rental_log
  end

  def test_it_can_find_renter_credit_card
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)

    assert_equal "4242424242424242", dock.renter_credit_card(kayak_1)
    assert_equal "4242424242424242", dock.renter_credit_card(kayak_2)
    assert_equal "1313131313131313", dock.renter_credit_card(sup_1)
  end

  def test_it_can_find_the_charge_amount
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    dock.rent(kayak_1, patrick)
    kayak_1.add_hour
    kayak_1.add_hour

    assert_equal 40, dock.charge_amount(kayak_1)
  end

  def test_it_knows_when_it_has_the_max_rental_time
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(sup_1, eugene)
    kayak_1.add_hour
    kayak_1.add_hour
    sup_1.add_hour
    sup_1.add_hour
    sup_1.add_hour
    sup_1.add_hour
    sup_1.add_hour

    assert_equal false, dock.max_rental_time?(kayak_1)
    assert_equal true, dock.max_rental_time?(sup_1)
  end

  def test_it_knows_how_much_to_charge
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    dock.rent(kayak_1, patrick)
    kayak_1.add_hour
    kayak_1.add_hour

    expected = {
      :card_number => "4242424242424242",
      :amount => 40
    }

    assert_equal expected, dock.charge(kayak_1)

    kayak_1.add_hour

    expected_2 = {
      :card_number => "4242424242424242",
      :amount => 60
    }

    assert_equal expected_2, dock.charge(kayak_1)
  end

  def test_it_knows_the_max_charge_amount
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    dock.rent(kayak_1, patrick)

    assert_equal 60, dock.max_charge_amount(kayak_1)
  end

  def test_iteration_3_test_suite
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)
    kayak_1.add_hour
    kayak_1.add_hour

    expected = {
      :card_number => "4242424242424242",
      :amount => 40
    }

    assert_equal expected, dock.charge(kayak_1)

    sup_1.add_hour
    sup_1.add_hour
    sup_1.add_hour

    # Any hours past the max rental time should not count
    sup_1.add_hour
    sup_1.add_hour

    expected_2 = {
      :card_number => "1313131313131313",
      :amount => 45
    }

    assert_equal expected_2, dock.charge(sup_1)
  end
end
