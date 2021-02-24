require "./lib/boat"
require "minitest/autorun"

class BoatTest < Minitest::Test
  def test_it_exists
    kayak = Boat.new(:kayak, 20)
    assert_instance_of Boat, kayak
  end

  def test_it_has_attributes
    kayak = Boat.new(:kayak, 20)
    assert_equal :kayak, kayak.type
    assert_equal 20, kayak.price_per_hour
    assert_equal 0, kayak.hours_rented
  end

  def test_it_can_add_hours
    kayak = Boat.new(:kayak, 20)
    assert_equal 1, kayak.add_hour
    assert_equal 1, kayak.hours_rented
  end

  def test_iteration_1_test_suite
    kayak = Boat.new(:kayak, 20)
    kayak.add_hour
    kayak.add_hour
    kayak.add_hour
    assert_equal 3, kayak.hours_rented
  end

  def test_it_can_find_total_charge_amount
    kayak = Boat.new(:kayak, 20)
    kayak.add_hour
    kayak.add_hour
    kayak.add_hour
    assert_equal 60, kayak.total_charge
  end

  def test_it_can_be_checked_out
    kayak = Boat.new(:kayak, 20)
    assert_nil kayak.rented
    assert kayak.check_out
  end

  def test_it_can_tell_if_returned
    kayak = Boat.new(:kayak, 20)
    assert_nil kayak.rented
    assert kayak.check_out
    refute kayak.check_in
  end
end
