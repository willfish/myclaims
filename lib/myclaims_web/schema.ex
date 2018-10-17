defmodule Schema do
  use Absinthe.Schema

  import_types Schema.AccountTypes
  import_types Schema.ClaimTypes
  import_types Schema.ScalarTypes

  query do
    field :claims, list_of(:claim) do
      arg(:filter, :claims_filter)
      resolve(&Resolvers.Claims.claims/3)
    end

    field :claim, :claim do
      @desc "ID of the claim"
      arg(:id, non_null(:id))
      resolve(&Resolvers.Claims.claim/3)
    end
  end

  mutation do
    @desc "Retrieve session information for subsequent authentication"
    field :login, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &Resolvers.Accounts.login/3

      # Intercept the login result and cache it in the stateful context
      # for the current user
      middleware fn res, _ ->
        with %{value: %{token: token, user: user}} <- res do
          context = Map.put(res.context, :current_user, user)
          context = Map.put(res.context, :token, token)
          %{res | context: context }
        end
      end
    end

    @desc "Submit a new claim"
    field :new_claim, :claim do
      arg(:input, non_null(:new_claim_input))
      middleware Middleware.Authorization, "any"
      resolve(&Resolvers.Claims.new_claim/3)
    end

    @desc "Marks the claim as being in the REPORTED state"
    field :reported, :claim do
      @desc "ID of the claim"
      arg :id, non_null(:id)
      middleware Middleware.Authorization, "admin"
      resolve &Resolvers.Claims.reported/3
    end

    @desc "Marks the claim as being with the underwriter."
    field :with_underwriter, :claim do
      @desc "ID of the claim"
      arg :id, non_null(:id)
      middleware Middleware.Authorization, "admin"
      resolve &Resolvers.Claims.with_underwriter/3
    end

    @desc "Marks the claim as being with the assessor."
    field :with_assessor, :claim do
      @desc "ID of the claim"
      arg :id, non_null(:id)
      middleware Middleware.Authorization, "admin"
      resolve &Resolvers.Claims.with_assessor/3
    end

    @desc "Marks the claim as being in the COMPLETED state"
    field :completed, :claim do
      @desc "ID of the claim"
      arg :id, non_null(:id)
      middleware Middleware.Authorization, "admin"
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
