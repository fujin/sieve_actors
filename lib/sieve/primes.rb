require_relative "controller"

module Sieve
  class Primes
    include Enumerable

    def initialize
      @controller = Controller.new
    end

    def each
      loop do
        yield @controller.next
      end
    end
  end
end
