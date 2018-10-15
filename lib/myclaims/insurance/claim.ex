defmodule Myclaims.Insurance.Claim do
  use Ecto.Schema
  import Ecto.Changeset


  schema "claims" do
    field :coordinates, :map
    field :metadata, :map
    field :state, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(claim, attrs) do
    claim
    |> cast(attrs, [:state, :coordinates, :metadata])
    |> validate_required([:state, :coordinates, :metadata])
  end
end
