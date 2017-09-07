defmodule Inflator.Repo.Migrations.CreateInflations do
  use Ecto.Migration

  def change do
    create table(:inflations) do
      add :date, :string
      add :borough, :string
      add :index, :float

      timestamps()
    end

  end
end
