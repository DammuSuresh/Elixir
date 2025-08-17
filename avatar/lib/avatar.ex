# import Mogrify
defmodule Avatar do
  import Mogrify
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    # |> save_image(input)
  end

  def draw_image(%Avatar.Image{color: color, pixel_map: pixel_map}) do
    # image = :egd.create(250, 250)
    # fill = :egd.color(color)
    #   Enum.each pixel_map, fn ({start, stop}) ->
    #     :egd.filledRectangle(image, start, stop, fill)
    #   end
    # :egd.render(image)


    # Create a blank 250x250 white canvas
    image =
      %Mogrify.Image{path: "blank.png", ext: "png"}
            |> create_blank(250, 250)
            |> custom("size", "250x250")
            |> canvas("white")

    # Draw rectangles for each pixel in pixel_map
    Enum.reduce(pixel_map, image, fn {start, stop}, img ->
      draw_command = "rectangle #{elem(start, 0)},#{elem(start, 1)} #{elem(stop, 0)},#{elem(stop, 1)}"
      img |> custom("draw", draw_command)
      |> save(in_place: true)
    end)
  end

  defp create_blank(img, width, height) do
    img
    |> custom("size", "#{width}x#{height}")
    # |> custom("xc:rgb(#{r},#{g},#{b})")
    |> save(path: "blank.png")
  end

  def build_pixel_map(%Avatar.Image{grid: grid} = image) do
     pixel_map = Enum.map grid, fn({_code, index}) ->
        horizantal = rem(index,5) * 5
        vertical = div(index,5) * 5

        top_left = {horizantal, vertical}
        bottom_right = {horizantal + 50, vertical + 50}
        {top_left, bottom_right}
      end
      %Avatar.Image{image | pixel_map: pixel_map}
  end
  def hash_input(str) do
      hex = :crypto.hash(:md5, str)
      |> :binary.bin_to_list
      %Avatar.Image{hex: hex}
  end

  def pick_color(%Avatar.Image{hex: [r, g, b | _tail]} = image) do
    #  %Avatar.Image{hex: hex_list} = image
    #  [r,g,b]
     %Avatar.Image{image | color: {r, g, b}}
  end

  def build_grid(%Avatar.Image{hex: hex} = image) do
    grid = hex
    # Inspect.put(hex)
    |> Enum.chunk_every(3,  3, :discard)
    |> Enum.map(&mirror_row/1) # & means reference to this function 1 means mirror_row takes only one argument
    |> List.flatten
    |> Enum.with_index

    %Avatar.Image{image | grid: grid}
  end

  def filter_odd_squares(%Avatar.Image{grid: grid} = image) do
     grid = Enum.filter(grid, fn({code, _index})  ->
        rem(code, 2) == 0
       end)
       %Avatar.Image{image | grid: grid}
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
