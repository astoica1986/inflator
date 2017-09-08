defmodule Mix.Tasks.Inflator.ImportCsv do
  use Mix.Task
  alias Inflator.CVSImporter

  def run(file) do
    if is_valid_file?(file) do
      IO.puts  "#{file} exists on local and it has a csv extension"
      CVSImporter.call(file)
    else
      IO.puts "File doesn't exist or is not a csv"
    end
  end

  defp is_valid_file?(file) do
    File.regular?(file) && Path.extname(file) == ".csv"
  end
end
