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

  subscription do
    field :claim_changes, :claim do
      arg :user_id, non_null(:id)

      config fn %{user_id: id}, _info ->
        {:ok, topic: id}
      end

      trigger [:reported, :with_underwriter, :with_assessor, :completed], topic: fn
        %{claim: claim} -> [claim.id]
        _ -> []
      end

      resolve fn %{claim: claim}, _ , _ ->
        {:ok, claim}
      end
    end

    field :new_claims, :claim do
      config fn _args, _info ->
        {:ok, topic: "new_claim"}
      end
    end
  end
end
