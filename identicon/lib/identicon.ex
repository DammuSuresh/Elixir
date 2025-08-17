defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
      Enum.each pixel_map, fn ({start, stop}) ->
        :egd.filledRectangle(image, start, stop, fill)
      end
    :egd.render(image)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
     pixel_map = Enum.map grid, fn({_code, index}) ->
        horizantal = rem(index,5) * 5
        vertical = div(index,5) * 5

        top_left = {horizantal, vertical}
        bottom_right = {horizantal + 50, vertical + 50}
        {top_left, bottom_right}
      end
      %Identicon.Image{image | pixel_map: pixel_map}
  end
  def hash_input(str) do
      hex = :crypto.hash(:md5, str)
      |> :binary.bin_to_list
      %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    #  %Identicon.Image{hex: hex_list} = image
    #  [r,g,b]
     %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = hex
    # Inspect.put(hex)
    |> Enum.chunk_every(3,  3, :discard)
    |> Enum.map(&mirror_row/1) # & means reference to this function 1 means mirror_row takes only one argument
    |> List.flatten
    |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
     grid = Enum.filter(grid, fn({code, _index})  ->
        rem(code, 2) == 0
       end)
       %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    # [145, 46, 200]
    [first, second | _tail] = row
    row ++ [second, first]
  end
  def save_image(image, filename) do
    File.write("#{filename}.png", image)
  end
end
