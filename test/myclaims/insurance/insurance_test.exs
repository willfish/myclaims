defmodule Myclaims.InsuranceTest do
  use Myclaims.DataCase

  alias Myclaims.Insurance

  describe "claims" do
    alias Myclaims.Insurance.Claim

    @valid_attrs %{coordinates: %{}, metadata: %{}, state: "some state"}
    @update_attrs %{coordinates: %{}, metadata: %{}, state: "some updated state"}
    @invalid_attrs %{coordinates: nil, metadata: nil, state: nil}

    def claim_fixture(attrs \\ %{}) do
      {:ok, claim} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Insurance.create_claim()

      claim
    end

    test "list_claims/0 returns all claims" do
      claim = claim_fixture()
      assert Insurance.list_claims() == [claim]
    end

    test "get_claim!/1 returns the claim with given id" do
      claim = claim_fixture()
      assert Insurance.get_claim!(claim.id) == claim
    end

    test "create_claim/1 with valid data creates a claim" do
      assert {:ok, %Claim{} = claim} = Insurance.create_claim(@valid_attrs)
      assert claim.coordinates == %{}
      assert claim.metadata == %{}
      assert claim.state == "some state"
    end

    test "create_claim/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Insurance.create_claim(@invalid_attrs)
    end

    test "update_claim/2 with valid data updates the claim" do
      claim = claim_fixture()
      assert {:ok, claim} = Insurance.update_claim(claim, @update_attrs)
      assert %Claim{} = claim
      assert claim.coordinates == %{}
      assert claim.metadata == %{}
      assert claim.state == "some updated state"
    end

    test "update_claim/2 with invalid data returns error changeset" do
      claim = claim_fixture()
      assert {:error, %Ecto.Changeset{}} = Insurance.update_claim(claim, @invalid_attrs)
      assert claim == Insurance.get_claim!(claim.id)
    end

    test "delete_claim/1 deletes the claim" do
      claim = claim_fixture()
      assert {:ok, %Claim{}} = Insurance.delete_claim(claim)
      assert_raise Ecto.NoResultsError, fn -> Insurance.get_claim!(claim.id) end
    end

    test "change_claim/1 returns a claim changeset" do
      claim = claim_fixture()
      assert %Ecto.Changeset{} = Insurance.change_claim(claim)
    end
  end
end
