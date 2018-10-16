defmodule Schema.AccountTypes do
  use Absinthe.Schema.Notation

  object :session do
    field :token, :string
    field :user, :user
  end

  enum :user_type do
    value :admin
    value :customer
  end

  interface :user do
    field :email, :string
    field :type, :string

    resolve_type fn
      %{type: "admin"}, _ -> :admin
      %{type: "customer"}, _ -> :customer
    end
  end

  object :admin do
    interface :user

    field :email, :string
    field :type, :string
  end

  object :customer do
    interface :user

    field :email, :string
    field :claims, list_of(:claim) do
    end
    resolve fn customer, _, _ ->
      claims =
        %{filter: %{user_id: customer.id}}
        |> MyClaims.Insurance.list_claims()

      {:ok, claims}
    end
  end
end
