defmodule SieveOfErathosthenes do
	@moduledoc false

	@first_prime 2

	def primes(n) do
		potential_primes = :lists.seq(@first_prime, n)
		p = @first_prime
		sweep(potential_primes, p, n)
	end

	def sweep(potential_primes, p, n) do
		sweep =
			case p * p > n do
				true -> []
				false -> :lists.seq(p * p, n, p)
			end

		swept_primes = potential_primes -- sweep
		case Enum.find(swept_primes, fn e -> e > p end) do
			nil -> swept_primes
			new_p -> sweep(swept_primes, new_p, n)
		end
	end
end
