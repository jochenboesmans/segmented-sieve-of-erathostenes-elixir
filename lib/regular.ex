defmodule SieveOfErathosthenes.Regular do
	@moduledoc """
	Functions for generating prime numbers up to a given limit n using the sieve of Eratosthenes method.
	"""

	@first_prime 2

	@doc """
	Returns a list of all prime numbers up to a given limit n.
	"""
	@spec primes(integer) :: [integer]
	def primes(n), do: sweep(potential_primes(n), @first_prime, n)

	@spec potential_primes(integer) :: [integer]
	defp potential_primes(n), do: :lists.seq(@first_prime, n)

	@spec sweep([integer], integer, integer) :: [integer]
	defp sweep(potential_primes, p, n) do
		swept_primes = potential_primes -- composites(p, n)
		case Enum.find(swept_primes, fn e -> e > p end) do
			nil -> swept_primes
			new_p -> sweep(swept_primes, new_p, n)
		end
	end

	@spec composites(integer, integer) :: [integer]
	defp composites(p, n) do
		case p * p > n do
			true -> []
			false -> :lists.seq(p * p, n, p)
		end
	end
end
