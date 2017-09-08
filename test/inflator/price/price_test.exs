#require IEx
defmodule Inflator.PriceTest do
  use Inflator.DataCase
  alias Inflator.Price

  @from_attrs %{borough: "some borough", date: "01/04/2010", index: 120.5}
  @to_attrs %{borough: "some borough", date: "01/05/2011", index: 456.7}
  @valid_search_params %{borough: "some borough", to: "01/05/2011", from: "01/04/2010", price: "500"}
  @invalid_search_params %{borough: "none existing borough", to: "01/05/2011", from: "01/04/2010"}
  @invalid_attrs %{}

  def from_inflation_fixture(attrs \\ %{}) do
    {:ok, inflation} =
      attrs
      |> Enum.into(@from_attrs)
      |> Price.create_inflation()

    inflation
  end

  def to_inflation_fixture(attrs \\ %{}) do
    {:ok, inflation} =
      attrs
      |> Enum.into(@to_attrs)
      |> Price.create_inflation()

    inflation
  end

  describe "inflations" do
    alias Inflator.Price.Inflation

    test "get inflated price" do
      from_inflation_fixture()
      to_inflation_fixture()
      inflated_price = Price.get_inflated_price(
        @valid_search_params.to,
        @valid_search_params.from,
        @valid_search_params.price,
        @valid_search_params.borough
      )
    #  IEx.pry
    #  assert %{:ok, _price} == inflated_price
    end

    test "create_inflation/1 with valid data creates a inflation" do
      assert {:ok, %Inflation{} = inflation} = Price.create_inflation(@from_attrs)
      assert inflation.borough == "some borough"
      assert inflation.date == "01/04/2010"
      assert inflation.index == 120.5
    end

    test "create_inflation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Price.create_inflation(@invalid_attrs)
    end
  end
end
