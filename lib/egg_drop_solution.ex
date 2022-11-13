defmodule EggDropSolution do
  @moduledoc """
    # Task description:

    Got N eggs and M skyscraper floors.

    What is the least amount of tries you need to find the floor on which egg will crash?
  """

  use Agent

  @doc """
    ## Examples
      iex> EggDropSolution.start(2, 10)
      4

      iex> EggDropSolution.start(2, 100)
      14

      iex> EggDropSolution.start(1, 10)
      10
  """
  @spec start(eggs :: number, floors :: number) :: number
  def start(eggs, floors) do
    Agent.start(fn -> %{} end, name: :cache)

    result = solution_loop(eggs, floors)

    Agent.stop(:cache)

    result
  end

  @spec solution_loop(eggs :: number, floors :: number) :: number
  defp solution_loop(eggs, floors) do
    # If exists in cache, return
    if Agent.get(:cache, fn x -> Map.has_key?(x, {eggs, floors}) end) do
      Agent.get(:cache, fn x -> Map.get(x, {eggs, floors}) end)
    else
      if floors === 0 || floors === 1 || eggs === 1 do
        Agent.update(:cache, fn x -> Map.put(x, {eggs, floors}, floors) end)
        floors
      else
        results =
          for i <- 1..floors do
            #   if egg crashes                   if not                           attempt
            max(solution_loop(eggs - 1, i - 1), solution_loop(eggs, floors - i)) + 1
          end

        min_result = Enum.min(results)

        Agent.update(:cache, fn x -> Map.put(x, {eggs, floors}, min_result) end)

        min_result
      end
    end
  end
end
