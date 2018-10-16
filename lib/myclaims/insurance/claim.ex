defmodule Myclaims.Insurance.Claim do
  use Ecto.Schema
  import Ecto.Changeset

  schema "claims" do
    field(:coordinates, :map)
    field(:metadata, :map)
    field(:state, :string)
    field(:received, :naive_datetime)
    field(:occurred, :naive_datetime)
    field(:resolved, :naive_datetime)
    belongs_to(:user, Myclaims.Coherence.User, references: :user_id)

    timestamps()
  end

  @doc false
  def changeset(claim, attrs) do
    claim
    |> cast(attrs, [:state, :coordinates, :metadata, :received, :occurred, :resolved])
    |> validate_required([:state, :coordinates, :metadata])
  end
end
