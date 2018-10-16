defmodule Resolvers.Claims do
  def claims(_, args, _) do
    {:ok, Myclaims.Insurance.list_claims(args)}
  end

  def claim(_, %{id: id}, _) do
    {:ok, Myclaims.Insurance.get_claim!(id)}
  end
end
