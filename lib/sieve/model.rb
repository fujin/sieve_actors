require 'celluloid'

module Sieve
  # A model represents a fragment of the state of our sieve, specifically some subset
  # of the primes discovered so far.
  #
  # In the Celluloid model there is no one unified entry point for message handling.  Each handled
  # message type is now implemented as a distinct method that can be called synchronously or
  # asynchronously.  Since method calls are logically equivalent to messages (see Smalltalk)
  # this should work reasonably well.
  class Model
    include Celluloid

    def initialize
      @primes = []
    end

    def add newprime
      @primes << newprime
    end

    def is_prime candidate
      # Upfront validation; make sure we have some primes
      if @primes.empty?
        return nil
      end

      # The model only considers a value prime if it doesn't equal or divide evenly into any previously
      # observed prime.
      @primes.none? { |prime| candidate != prime and candidate % prime == 0 }
    end
  end
end
