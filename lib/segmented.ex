defmodule SieveOfEratosthenes.Segmented do
  @moduledoc """
  Functions for generating prime numbers up to a given limit n using the segmented sieve of Eratosthenes method.
  """

  alias SieveOfEratosthenes.Regular, as: SieveOfEratosthenes

  @one_hour 3_600_000

  @doc """
  Returns a list of all prime numbers up to a given limit n.
  """
  @spec primes(integer) :: [integer]
  def primes(n) do
    seg_size = segment_size(n)
    base = SieveOfEratosthenes.primes(seg_size)

    Enum.map(segments(n, seg_size), fn [min, max] ->
      Task.async(fn -> swept_segment(min, max, base) end) end)

    |> Enum.reduce(base, fn (task, acc) ->
      acc ++ Task.await(task, @one_hour) end)
  end

  @spec segment_size(integer) :: integer
  defp segment_size(n), do: trunc(:math.sqrt(n))

  @spec segments(integer, integer) :: [[integer]]
  defp segments(n, seg_size) do
    :lists.seq(seg_size, n - seg_size, seg_size)
    |> Enum.map(fn min -> [min, min + seg_size] end)
  end

  @spec swept_segment(integer, integer, [integer]) :: [integer]
  defp swept_segment(min, max, base) do
    # filter out any number that's a multiple of one or more integers from base
    SieveOfEratosthenes.potential_primes(min, max)
    |> Enum.filter(fn p ->
        Enum.all?(base, fn i -> rem(p, i) !== 0 end)
      end)
  end
end
