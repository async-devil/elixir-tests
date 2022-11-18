defmodule UglyNumberSolution do
  @moduledoc """
  An ugly number is a positive integer whose prime factors are limited to 2, 3, and 5.

  Given an integer n, return true if n is an ugly number.
  """

  @spec is_ugly(n :: integer) :: boolean
  def is_ugly(n) do
    if n <= 0 do
      false
    else
      iteration_loop(n) == 1
    end
  end

  def iteration_loop(n, i \\ 2) do
    if i <= 5 do
      iteration_loop(calculation_loop(n, i), i + i - 1)
    else
      n
    end
  end

  def calculation_loop(n, i) do
    if rem(round(n), i) === 0 do
      calculation_loop(n / i, i)
    else
      n
    end
  end
end
