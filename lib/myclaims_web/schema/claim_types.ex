defmodule Schema.ClaimTypes do
  use Absinthe.Schema.Notation

  object :claim do
    field(:id, :id, description: "ID of the claim")
    field(:coordinates, :map, description: "ID of the claim")
    field(:metadata, :map)
    field(:state, :string)
    field(:inserted_at, :string)
  end

  @desc "Filtering options for claims"
  input_object :claims_filter do
    field(:user_id, :id, description: "Matching a user id")
    field(:state, :string, description: "Matching a state")
    field(:created_before, :datetime, description: "Claim created before date")
    field(:created_after, :datetime, description: "Added to the menu after this date")
  end

  @desc "Input options for a new claim"
  input_object :new_claim_input do
    @desc "User to associate the claim with"
    field(:user_id, :id)
    @desc "The date the insurer first received the claim"
    field(:received, :datetime)
    @desc "The date the incident triggering the claim occurred"
    field(:occurred, :datetime)
    @desc "The date the claim was marked as resolved"
    field(:resolved, :datetime)
    @desc "Coordinates of where the claim occurred"
    field(:coordinates, non_null(:map))
    @desc "Any extra information about the claim"
    field(:metadata, non_null(:map))
  end
end
