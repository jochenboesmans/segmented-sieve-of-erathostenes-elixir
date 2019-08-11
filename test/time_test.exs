defmodule SieveOfEratosthenes.TimeTest do
	@moduledoc """
	Tests to showcase difference in time complexity between algorithms.
	"""
	use ExUnit.Case, async: true

	alias SieveOfEratosthenes.Regular
	alias SieveOfEratosthenes.Segmented

	test("Segmented sieve is faster than regular for high limits") do
		n = 10_000

		regular_start = :os.system_time(:millisecond)
		Regular.primes(n)
		regular_finish = :os.system_time(:millisecond)
		regular_time = regular_finish - regular_start

		segmented_start = :os.system_time(:millisecond)
		Segmented.primes(n)
		segmented_finish = :os.system_time(:millisecond)
		segmented_time = segmented_finish - segmented_start

		assert segmented_time < regular_time
	end

	test("Segmented sieve scales better than regular") do
		n1 = 10_000
		n2 = 100_000

		regular_n1_start = :os.system_time(:millisecond)
		Regular.primes(n1)
		regular_n1_finish = :os.system_time(:millisecond)
		regular_n1_time = regular_n1_finish - regular_n1_start

		segmented_n1_start = :os.system_time(:millisecond)
		Segmented.primes(n1)
		segmented_n1_finish = :os.system_time(:millisecond)
		segmented_n1_time = segmented_n1_finish - segmented_n1_start

		regular_n2_start = :os.system_time(:millisecond)
		Regular.primes(n2)
		regular_n2_finish = :os.system_time(:millisecond)
		regular_n2_time = regular_n2_finish - regular_n2_start

		segmented_n2_start = :os.system_time(:millisecond)
		Segmented.primes(n2)
		segmented_n2_finish = :os.system_time(:millisecond)
		segmented_n2_time = segmented_n2_finish - segmented_n2_start

		assert regular_n2_time / regular_n1_time > segmented_n2_time / segmented_n1_time
	end
end
