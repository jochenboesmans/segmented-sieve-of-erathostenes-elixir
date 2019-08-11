defmodule SegmentedSieveOfErathostenes do
  @moduledoc false

  alias SieveOfErathosthenes

  def primes(n) do
    segment_size = trunc(:math.sqrt(n))

    segment_mins = :lists.seq(segment_size, n - segment_size, segment_size)
    segments =
      Enum.map(segment_mins, fn segment_min ->
        [segment_min, segment_min + segment_size]
      end)

    first_segment = SieveOfErathosthenes.primes(segment_size)

    Enum.reduce(segments, first_segment, fn ([min, max], acc) ->
      acc ++ swept_segment(min, max, first_segment)
    end)
  end

  defp swept_segment(min, max, first_segment) do
    :lists.seq(min, max)
    |> Enum.filter(fn p ->
      Enum.all?(first_segment, fn i ->
        rem(p, i) !== 0
      end)
    end)
  end
end
