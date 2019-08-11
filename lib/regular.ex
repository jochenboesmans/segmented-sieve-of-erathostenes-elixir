defmodule SieveOfEratosthenes.Regular do
	@moduledoc """
	Functions for generating prime numbers up to a given limit n using the sieve of Eratosthenes method.
	"""

	@first_prime 2

	@doc """
	Returns a list of all prime numbers up to a given limit n.
	"""
	@spec primes(integer) :: [integer]
	def primes(n) do
		sweep([@first_prime | potential_primes(@first_prime, n)], @first_prime, n)
	end

	@spec potential_primes(integer, integer) :: [integer]
	def potential_primes(min, max) do
		# return list of odd numbers between min and max
		case rem(min, 2) === 0 do true -> min + 1; false -> min end
		|> :lists.seq(max, 2)
	end

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
