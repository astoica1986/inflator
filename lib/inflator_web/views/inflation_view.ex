defmodule InflatorWeb.InflationView do
  use InflatorWeb, :view
  alias InflatorWeb.InflationView

  def render("inflated_price.json", %{inflated_price: inflated_price}) do
    %{inflated_price: inflated_price}
  end

  def render("error.json", %{error: error_string}) do
    %{error: "Could not process inflated price. Reason: #{error_string}"}
  end
end
