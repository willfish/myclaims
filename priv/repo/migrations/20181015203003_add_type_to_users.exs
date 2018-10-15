defmodule Myclaims.Repo.Migrations.AddTypeToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :type, :string, default: "ADMIN"
    end
  end
end
