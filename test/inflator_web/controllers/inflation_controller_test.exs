defmodule InflatorWeb.InflationControllerTest do
  use InflatorWeb.ConnCase

  alias Inflator.Price
  alias Inflator.Price.Inflation
  import Mock

  @create_attrs %{borough: "some borough", date: "01/04/2010", index: 120.5}
  @update_attrs %{borough: "some updated borough", date: "01/05/2011", index: 456.7}
  @invalid_attrs %{borough: nil, date: nil, index: nil}
  @mock_inflated_price 500_123.345
  def fixture(:inflation) do
    {:ok, inflation} = Price.create_inflation(@create_attrs)
    inflation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "get_inflated_price" do
    test "return inflated price json", %{conn: conn} do
      with_mock Price, [get_inflated_price: fn(_to, _from, _price, _borough) -> {:ok, @mock_inflated_price} end] do
        conn = get conn, inflation_path(
          conn,
          :get_inflated_price,
          to: "a", from: "b", price: 0, borough: "abc"
        )
        assert json_response(conn, 200) == %{ "inflated_price" => @mock_inflated_price}
      end
    end
  end

  defp create_inflation(_) do
    inflation = fixture(:inflation)
    {:ok, inflation: inflation}
  end
end
