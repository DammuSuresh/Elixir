defmodule Cards do
 def decks do
   ["One", "Two", "Three"]
 end

 def shuffle(dec) do
      Enum.shuffle(dec)
 end

 def contains?(desc, hand) do
    Enum.member?(desc,hand)
 end
end
