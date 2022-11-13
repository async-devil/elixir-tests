defmodule RockPaperScissors do
  @moduledoc false

  @spec get_rand_option :: String.t()
  def get_rand_option() do
    Enum.random(["rock", "paper", "scissors"])
  end

  @spec get_player_option :: String.t()
  def get_player_option() do
    option = IO.gets("rock, paper, scissors? ")
    option = option |> String.downcase() |> String.trim()

    if option in ["rock", "paper", "scissors"], do: option, else: get_player_option()
  end

  @spec get_winner(player_option :: String.t(), random_option :: String.t()) :: atom()
  def get_winner("rock", "paper"), do: :computer
  def get_winner("paper", "rock"), do: :player

  def get_winner("rock", "scissors"), do: :player
  def get_winner("scissors", "rock"), do: :computer

  def get_winner("paper", "scissors"), do: :computer
  def get_winner("scissors", "paper"), do: :player

  def get_winner(_, _), do: :draw

  @spec play :: :ok
  def play() do
    computer_option = get_rand_option()
    player_option = get_player_option()

    result = get_winner(player_option, computer_option)

    IO.puts(
      "Your choice: #{player_option}, computer choice: #{computer_option}, result: #{result}"
    )
  end
end
