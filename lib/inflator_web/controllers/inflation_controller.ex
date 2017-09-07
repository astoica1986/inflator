require IEx
defmodule InflatorWeb.InflationController do
  use InflatorWeb, :controller

  alias Inflator.Price
  alias Inflator.Price.Inflation

  action_fallback InflatorWeb.FallbackController

  def get_inflated_price(conn,
   %{"to" => to, "from" => from, "price" => price, "borough" =>borough} = params
  ) do
    result= Price.get_inflated_price(to, from, price, borough)
  #  IEx.pry
    case result do
      {:ok, inflated_price} ->
        render(conn, "inflated_price.json", inflated_price: inflated_price)
      {:error, error_string} ->
        render(conn, "error.json", error: error_string)
    end

  end
end
