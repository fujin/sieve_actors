require 'minitest/autorun'
require 'prime'
require 'sieve/primes'

class PrimesTest < MiniTest::Unit::TestCase

  # Verify that we can at least obtain the seeded values from the controller
  def test_controller_seeds_only
    assert_equal([2,3,5,7],Sieve::Primes.new.take(4))
  end

  # Now verify that the controller correctly computes new primes.  Don't forget
  # to skip past the seeded values!
  def test_controller_computed_primes

    assert_equal(Sieve::Primes.new.take(104)[4,-1], Prime.each.take(104)[4,-1])
  end
end
