defmodule RpsSimulation do
  def run(%File.Stream{} = io, strategy) do
    Enum.reduce(io, 0, fn move, acc ->
      score = move
              |> String.split()
              |> Enum.map(&value/1)
              |> List.to_tuple()
              |> decide(strategy)
              |> play()

      acc + score
    end)
  end

  defp value(move) do
    cond do
      move in ["A", "X"] -> 1
      move in ["B", "Y"] -> 2
      move in ["C", "Z"] -> 3
    end
  end

  defp decide(move, :choice), do: move
  defp decide({them, 3 = _win}, :force), do: {them, them+1}
  defp decide({them, 2 = _tie}, :force), do: {them, them}
  defp decide({them, 1 = _lose}, :force), do: {them, them-1}

  defp play({them, 0}), do: play({them, 3})
  defp play({them, 4}), do: play({them, 1})
  defp play({them, me}) when me - them in [1, -2], do: me + 6
  defp play({them, me}) when me == them, do: me + 3
  defp play({_them, me}), do: me
end

RpsSimulation.run(File.stream!("example.txt"), :choice)
|> IO.inspect(label: "Ex Part 1")

RpsSimulation.run(File.stream!("input.txt"), :choice)
|> IO.inspect(label: "Part 1")

RpsSimulation.run(File.stream!("example.txt"), :force)
|> IO.inspect(label: "Ex Part 2")

RpsSimulation.run(File.stream!("input.txt"), :force)
|> IO.inspect(label: "Part 2")
