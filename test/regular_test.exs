defmodule SieveOfEratosthenes.RegularTest do
  use ExUnit.Case, async: true

  alias SieveOfEratosthenes.Regular, as: SieveOfEratosthenes

  doctest SieveOfEratosthenes

  test "correctly generates primes up to 10" do
    assert SieveOfEratosthenes.primes(10) == [2, 3, 5, 7]
  end

  test "correctly generates primes up to 100" do
    expected_output = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
    assert SieveOfEratosthenes.primes(100) == expected_output
  end

  test "includes limit if it is a prime itself" do
    test_prime = 7
    assert Enum.any?(SieveOfEratosthenes.primes(test_prime), fn p -> p === test_prime end)
  end
end
