defmodule Mix.Tasks.Inflator.ImportCsv do
  use Mix.Task

  def run(nil) do
    IO.puts "Hello World!"
  end

  def run(file) do
    IO.puts "Redeaing file #{file}"
  end
end
