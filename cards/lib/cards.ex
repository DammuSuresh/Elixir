defmodule Cards do
  @moduledoc """
    This is module documentation
    Provides methods for creating and handling a deck of cards

    ## To generate document
        Project>  mix doc
  """

  @doc """
  Returns list of string elements
  """
 def create_decks do
  values = ["One", "Two", "Three"]
  suits = ["Spades", "Clubs", "Hearts"]
  # Solution 1 nested loops and flatten
  #  for value <- values do
  #   for suit <- suits do
  #   "#{value} of #{suit}"
  # end
  # end
   # List.flatten(cards) To flatten list data
# Solution 2 Comperenshion with multiple list values
  for suit <- suits , value <- values do
    "#{value} of #{suit}"
  end

 end

 def shuffle(dec) do
      Enum.shuffle(dec)
 end
 @doc """
 TO check value is present or not

 ## Example
      iex> deck = Cards.create_decks()
      iex> Cards.contains?(deck,"One of Spades")
      true
      iex> Cards.contains?(deck,"One of Spades 1")
      false

 """
 def contains?(desc, hand) do
    Enum.member?(desc,hand)
 end
 @doc """
 This deal function divides a deck into a hand and the reminder of the deck
 The `num` argument indicates how many cards should be in hand

 ## Examples


     iex> deck = Cards.create_decks
     iex> {hand, deck} = Cards.deal(deck, 1)
     iex> hand
     iex> ["One of Spades"]
 """
 def deal(decs, num) do
   Enum.split(decs, num)
 end

 def save_dec(file, name) do
   binary = :erlang.term_to_binary(file)
   File.write(name,binary)
 end

 def loadfile(filename) do
  #  {status, binary} = File.read(filename)
  #  status === 'ok'
  # if(status === :ok) dont use it

  case File.read(filename) do
    {:ok, abc} -> :erlang.binary_to_term(abc)
    {:error, _} -> "Something went wrong !!! "
  end



  # atom
  #  atoms are premitive data types
  #  example :ok :error
  # _reason when we use underscore before variable it means unused varibale
  # dec = Cards.create_decks()
    # cards = Cards.shuffle(dec)
    # hand = Cards.deals(cards, hand_size)

 end
  def create_hand(hand_size) do
    Cards.create_decks()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
