defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  def hash_input(str) do
      hex = :crypto.hash(:md5, str)
      |> :binary.bin_to_list
      %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r,g,b | _]} = image) do
    #  %Identicon.Image{hex: hex_list} = image
    #  %Identicon.Image{hex: [r,g,b | _]} = image # Pattren matching
      # = hex_list
     [r,g,b]
     %Identicon.Image{image | color: {r,g,b}}

  end
  def save_image(file,filename) do
    "Saving Image"
  end
end
