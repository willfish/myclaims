defmodule Schema do
  use Absinthe.Schema

  import_types Schema.ClaimTypes
  import_types Schema.ScalarTypes

  query do
    field :claims, list_of(:claim) do
      arg :filter, :claims_filter
      resolve &Resolvers.Claims.claims/3
    end

    field :claim, :claim do
      @desc "ID of the claim"
      arg :id, non_null(:id)
      resolve &Resolvers.Claims.claim/3
    end
  end

  mutation do
    @desc "Marks the claim as being in the REPORTED state"
    field :reported, :claim do
      arg :id, non_null(:id)
      resolve &Resolvers.Claims.reported/3
    end

    @desc "Marks the claim as being with the underwriter."
    field :with_underwriter, :claim do
      arg :id, non_null(:id)
      resolve &Resolvers.Claims.with_underwriter/3
    end

    @desc "Marks the claim as being with the assessor."
    field :with_assessor, :claim do
      arg :id, non_null(:id)
      resolve &Resolvers.Claims.with_assessor/3
    end

    @desc "Marks the claim as being in the COMPLETED state"
    field :completed, :claim do
      arg :id, non_null(:id)
      resolve &Resolvers.Claims.completed/3
    end
  end
end
