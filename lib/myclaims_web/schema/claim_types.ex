defmodule Schema.ClaimTypes do
  use Absinthe.Schema.Notation

  object :claim do
    field :id, :id
    field :coordinates, :map
    field :metadata, :map
    field :state, :string
    field :inserted_at, :string
  end


  @desc "Filtering options for claims"
  input_object :claims_filter do
    field :state, :string, description: "Matching a state"
    field :created_before, :datetime, description: "Claim created before date"
    field :created_after, :datetime, description: "Added to the menu after this date"
  end
end
