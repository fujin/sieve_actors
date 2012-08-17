module Sieve
  # Enumerable implementation representing the set of prime number candidates > 10.  Use of an
  # enumerable here allows us to isolate the state associated with candidate selection to this
  # class, freeing up the model and controller actors to focus on other parts of the computation
  class Candidates
    include Enumerable

    def initialize
      # Note that this initial value is never actually returned; we're only setting the stage for the
      # first increment to generate the first candidate
      @next = 9
    end

    # Primes must be a number ending in 1, 3, 7 or 9... a bit of reflection will make it clear why
    def each
      loop do
        @next += (@next % 10 == 3) ? 4 : 2
        yield @next
      end
    end
  end
end
