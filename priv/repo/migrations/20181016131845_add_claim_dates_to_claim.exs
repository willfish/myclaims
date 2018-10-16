defmodule Myclaims.Repo.Migrations.AddClaimDatesToClaim do
  use Ecto.Migration

  def change do
    alter table("claims") do
      add :received, :naive_datetime
      add :occurred, :naive_datetime
      add :resolved, :naive_datetime
    end
  end
end
