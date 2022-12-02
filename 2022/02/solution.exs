defmodule RpsSimulation do
  defguardp is_rock(value) when value == "A" or value == "X" or value == :rock
  defguardp is_paper(value) when value == "B" or value == "Y" or value == :paper
  defguardp is_scissors(value) when value == "C" or value == "Z" or value == :scissors

  defguardp is_lose(value) when value == "X"
  defguardp is_tie(value) when value == "Y"
  defguardp is_win(value) when value == "Z"

  def run(%File.Stream{} = io, strategy), do: Enum.reduce(io, 0, &(&2 + _run(&1, strategy)))

  defp _run(guide, :choice) do
    guide
    |> String.split()
    |> List.to_tuple()
    |> play()
  end

  defp _run(guide, :force) do
    guide
    |> String.split()
    |> List.to_tuple()
    |> force()
    |> play()
  end

  defp force({them, me}) when is_rock(them) and is_lose(me), do: {:rock, :scissors}
  defp force({them, me}) when is_rock(them) and is_tie(me), do: {:rock, :rock}
  defp force({them, me}) when is_rock(them) and is_win(me), do: {:rock, :paper}
  defp force({them, me}) when is_paper(them) and is_lose(me), do: {:paper, :rock}
  defp force({them, me}) when is_paper(them) and is_tie(me), do: {:paper, :paper}
  defp force({them, me}) when is_paper(them) and is_win(me), do: {:paper, :scissors}
  defp force({them, me}) when is_scissors(them) and is_lose(me), do: {:scissors, :paper}
  defp force({them, me}) when is_scissors(them) and is_tie(me), do: {:scissors, :scissors}
  defp force({them, me}) when is_scissors(them) and is_win(me), do: {:scissors, :rock}

  defp play({them, me}) when is_rock(them) and is_rock(me), do: score(:rock, :tie)
  defp play({them, me}) when is_rock(them) and is_paper(me), do: score(:paper, :win)
  defp play({them, me}) when is_rock(them) and is_scissors(me), do: score(:scissors, :lose)
  defp play({them, me}) when is_paper(them) and is_rock(me), do: score(:rock, :lose)
  defp play({them, me}) when is_paper(them) and is_paper(me), do: score(:paper, :tie)
  defp play({them, me}) when is_paper(them) and is_scissors(me), do: score(:scissors, :win)
  defp play({them, me}) when is_scissors(them) and is_rock(me), do: score(:rock, :win)
  defp play({them, me}) when is_scissors(them) and is_paper(me), do: score(:paper, :lose)
  defp play({them, me}) when is_scissors(them) and is_scissors(me), do: score(:scissors, :tie)

  defp score(:rock, result), do: score(1, result)
  defp score(:paper, result), do: score(2, result)
  defp score(:scissors, result), do: score(3, result)
  defp score(choice, :win), do: choice + 6
  defp score(choice, :tie), do: choice + 3
  defp score(choice, :lose), do: choice
end

RpsSimulation.run(File.stream!("example.txt"), :choice)
|> IO.inspect(label: "Ex Part 1")

RpsSimulation.run(File.stream!("input.txt"), :choice)
|> IO.inspect(label: "Part 1")

RpsSimulation.run(File.stream!("example.txt"), :force)
|> IO.inspect(label: "Ex Part 2")

RpsSimulation.run(File.stream!("input.txt"), :force)
|> IO.inspect(label: "Part 2")
