defmodule Inflator.CVSImporter do
  alias Inflator.Price.Inflation
  alias Inflator.Repo
  use Timex

  NimbleCSV.define(MyParser, separator: ",", escape: "\"")

  def call(file) do
    IO.puts "Trying to import #{file} in DB"
    Mix.Task.run "app.start"
    import_csv(file)
  end

  defp import_csv(file) do
    try do
      File.stream!(file)
      |> MyParser.parse_stream
      |> Stream.map(fn [date,borough,_,_,index | _t] ->
          {float_index, _} = Float.parse(index)
          %{date: date, borough: borough, index: float_index, inserted_at: Timex.now, updated_at: Timex.now}
        end)
      |> Stream.chunk(1000)
      |> Task.async_stream(&handle_chunk/1)
      |> Stream.run
    rescue
      _e in NimbleCSV.ParseError -> {:error, "Could not process csv. File may be corrupted"}
    end
  end

  defp handle_chunk(chunk) do
    Inflation |> Repo.insert_all(chunk)
  end
end
