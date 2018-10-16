defmodule Schema do
  use Absinthe.Schema

  import_types Schema.ClaimTypes
  import_types Schema.ScalarTypes
  # import_types Schema.AccountTypes

  query do
    # field :me, :user do
    #   middleware Middleware.Authorize, :any
    #   resolve &Resolvers.Accounts.me/3
    # end

    field :claims, list_of(:claim) do
      arg :filter, :claims_filter
      # arg :order, type: :sort_order, default_value: :asc
      resolve &Resolvers.Claims.claims/3
    end


     field :claim, :claim do
       @desc "ID of the claim"
       arg :id, non_null(:id)
       resolve &Resolvers.Claims.claim/3
     end
   end

  # mutation do
    # field :login, :session do
    #   arg :email, non_null(:string)
    #   arg :password, non_null(:string)
    #   arg :role, non_null(:role)
    #   resolve &Resolvers.Accounts.login/3
    #   middleware fn res, _ ->
    #     with %{value: %{user: user}} <- res do
    #       %{res | context: Map.put(res.context, :current_user, user)}
    #     end
    #   end
    # end

    # @desc "Marks the claim as being with the assessor."
    # field :with_assessor, :claim_change_result do
    #   arg :input, non_null(:claim_change_input)
    #   middleware Middleware.Authorize, "admin"
    #   resolve &Resolvers.Claims.with_assessor/3
    # end

    # @desc "Marks the claim as being with the underwriter."
    # field :with_underwriter, :claim_change_result do
    #   arg :input, non_null(:claim_change_input)
    #   middleware Middleware.Authorize, "admin"
    #   resolve &Resolvers.Claims.with_underwriter/3
    # end
  # end

  # subscription do
  #   @desc "Subscription for updates to a claim."
  #   field :update_claim, :claim do
  #     @desc "The id of the claim to subscribe too"
  #     arg :id, non_null(:id)

  #     config fn args, _info ->
  #       {:ok, topic: args.id}
  #     end

  #     trigger [:with_underwriter, :with_assessor], topic: fn
  #       %{claim: claim} -> [claim.id]
  #       _ -> []
  #     end

  #     resolve fn %{claim: claim}, _ , _ ->
  #       {:ok, claim}
  #     end
  #   end
  # end

  # enum :sort_order do
  #   value :asc
  #   value :desc
  # end
end
