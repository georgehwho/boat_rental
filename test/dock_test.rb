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
end
