defmodule Maps do
  @moduledoc """
  Maps in elixir similar to javascript objects

  ## Example 1 reading data from `Maps`
        %{primary : "red"}
        `Reading map data`
        iex> colors = %{primary:"red", secondary : "green"}
        iex> colors.primary
        "red"
        iex> colors.secondary
        "green"
        iex> {secondary: second_color} = colors
        iex> secondary
        "green"


  ## Example 2 Updating values in `Maps`
        iex>  colors = %{primary:"red", secondary : "green"}
        iex>  Map.put(colors, :primary , "blue")
        iex> colors
        %{primary:"red", secondary : "green"}
        iex> %{colors | :primary : "white"}
        %{primary:"white", secondary : "green"}
  """



end
