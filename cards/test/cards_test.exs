defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "validate contains method" do
    assert Cards.contains?(["Testing", "abc", "xys"], "abc") == :true
  end

  test "validate deck created length" do
    deck = Cards.create_decks
    assert length(deck) == 9
  end
@doc """
Insted of using ! symbol we have to use refute to check not equal
"""
  test "Shuffling with decks" do
    deck = Cards.create_decks
    refute deck == Cards.shuffle(deck)
  end

end
