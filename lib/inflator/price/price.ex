require IEx
defmodule Inflator.Price do
  @moduledoc """
  The Price context.
  """

  import Ecto.Query, warn: false
  alias Inflator.Repo

  alias Inflator.Price.Inflation


  @doc """
  Calculates an inflated prices using "to" and "from" dates, a borough name and a price.

  Raises `Ecto.NoResultsError` if the Inflation does not exist.

  ## Examples
      Assuming we return the following indexes for to and from dates: 103.60 , 28.25
      the inflated price will be £100,000 * (103.60 / 28.25) = £366,726
      iex> get_inflated_price("2016.01.01", "2000.01.01", 100,000, "Islington")
      366,726
  """
  def get_inflated_price(to, from, price, borough) do
    try do
      to_index = get_index(to, borough)
      from_index = get_index(from, borough)
      {float_price, _} = Float.parse(price)
      inflated_price = float_price * (to_index / from_index)
      {:ok, inflated_price}
    rescue
      e in ArithmeticError -> {:error, "Could not find indexes for given values"}
    end
  end

  @doc """
  Creates a inflation. Mostly just useful in tests

  ## Examples

      iex> create_inflation(%{field: value})
      {:ok, %Inflation{}}

      iex> create_inflation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inflation(attrs \\ %{}) do
    %Inflation{}
    |> Inflation.changeset(attrs)
    |> Repo.insert()
  end

  def get_index(date, borough) do
    query = from i in Inflation, select: i.index, where: i.date == ^date and i.borough == ^borough
     query |> Repo.one
  end
end
