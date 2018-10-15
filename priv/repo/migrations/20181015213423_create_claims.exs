defmodule Myclaims.Repo.Migrations.CreateClaims do
  use Ecto.Migration

  def change do
    create table(:claims) do
      add :state, :string
      add :coordinates, :map
      add :metadata, :map
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:claims, [:user_id])
  end
end
