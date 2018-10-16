defmodule Resolvers.Claims do
  def claims(_, args, _) do
    {:ok, Myclaims.Insurance.list_claims(args)}
  end

  def claim(_, %{id: id}, _) do
    {:ok, Myclaims.Insurance.get_claim!(id)}
  end

  def new_claim(_, _, _) do

  end

  def reported(_, %{id: id}, _) do
    {:ok, update_state(id, "REPORTED")}
  end

  def with_underwriter(_, %{id: id}, _) do
    {:ok, update_state(id, "WITH_LOSS_ADJUSTER")}
  end

  def with_assessor(_, %{id: id}, _) do
    {:ok, update_state(id, "WITH_LOSS_ASSESSOR")}
  end

  def completed(_, %{id: id}, _) do
    {:ok, update_state(id, "COMPLETED")}
  end

  defp update_state(id, state) do
    claim = Myclaims.Insurance.get_claim!(id)
    attrs = %{state: state}
    {:ok, claim} = Myclaims.Insurance.update_claim(claim, attrs)
    claim
  end
end
