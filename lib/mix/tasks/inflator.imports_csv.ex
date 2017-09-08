defmodule Mix.Tasks.Inflator.ImportCsv do
  use Mix.Task
  alias Inflator.CVSImporter
  @default_file_name "a.csv"
  
  def run(file) do
    if File.regular?(file) && Path.extname(file) == ".csv" do
      IO.puts  "#{file} exists on local and is a csv"
      CVSImporter.call(file)
    else
      IO.puts "File doesn't exist or is not a csv"
      IO.puts "Trying to download file"
    end
  end
end
