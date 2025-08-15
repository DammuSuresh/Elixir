defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "validate contains method" do
    assert Cards.contains?(["Testing", "abc", "xys"], "abc") == :true
  end

end
