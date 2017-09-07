defmodule Inflator.Price.Inflation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Inflator.Price.Inflation


  schema "inflations" do
    field :borough, :string
    field :date, :string
    field :index, :float

    timestamps()
  end

  @doc false
  def changeset(%Inflation{} = inflation, attrs) do
    inflation
    |> cast(attrs, [:date, :borough, :index])
    |> validate_required([:date, :borough, :index])
  end
end
