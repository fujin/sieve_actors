require 'celluloid'
require_relative "candidates"

module Sieve
  class Controller
    include Celluloid

    def initialize
      @models = 0.upto(3).map { |i| Model.new }

      # Seed models with a few initial values... just to get things going
      @seeds = [2,3,5,7]
      0.upto(3).each { |idx| @models[idx].add! @seeds[idx] }

      @candidates = Candidates.new
    end

    # Revert back to the old future-based semantics here.  This function has to support both
    # synchronous and async execution so it always has to return an answer when called.
    def next
      # If we still have seeds to return do so up front
      seed = @seeds.shift
      if seed
        return seed
      end

      # Otherwise loop through candidates and build a collection of futures (one for each model) for each
      # of those candidates.  The first value that returns all true values wins!
      nextprime = @candidates.find do |candidate|
        @models.map { |m| m.future :is_prime,candidate }.all? { |f| f.value }
      end

      # We found our next prime so update one of the models...
      @models[(rand @models.size)].add! nextprime

      # ... and return
      nextprime
    end
  end

end
