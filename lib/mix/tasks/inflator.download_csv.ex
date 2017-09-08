defmodule Mix.Tasks.Inflator.DownloadCsv do
  use Mix.Task
  @default_path "#{File.cwd!}/temp/index_csv_seed.csv"

  def run(url) do
    IO.puts "Attempting to download from #{url} to #{@default_path}"
    Mix.Task.run "app.start"
    url
      |> List.to_string
      |> Download.from([path: @default_path])
      |> handle_download_result
  end

  defp handle_download_result(result) do
    case result do
      { :ok, _stored_file_absolute_path } -> IO.puts "Download succesful!"
      { :error, :file_size_is_too_big } -> IO.puts "Requested file exceeds 1GB"
      { :error, :download_failure } -> IO.puts "Host unreachable"
      { :error, :eexist } -> IO.puts "File already exists"
      _ -> IO.puts "Download failed"
    end
  end

end
