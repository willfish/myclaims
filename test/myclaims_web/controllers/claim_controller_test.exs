defmodule MyclaimsWeb.ClaimControllerTest do
  use MyclaimsWeb.ConnCase

  alias Myclaims.Insurance

  @create_attrs %{coordinates: %{}, metadata: %{}, state: "some state"}
  @update_attrs %{coordinates: %{}, metadata: %{}, state: "some updated state"}
  @invalid_attrs %{coordinates: nil, metadata: nil, state: nil}

  def fixture(:claim) do
    {:ok, claim} = Insurance.create_claim(@create_attrs)
    claim
  end

  describe "index" do
    test "lists all claims", %{conn: conn} do
      conn = get conn, claim_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Claims"
    end
  end

  describe "new claim" do
    test "renders form", %{conn: conn} do
      conn = get conn, claim_path(conn, :new)
      assert html_response(conn, 200) =~ "New Claim"
    end
  end

  describe "create claim" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, claim_path(conn, :create), claim: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == claim_path(conn, :show, id)

      conn = get conn, claim_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Claim"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, claim_path(conn, :create), claim: @invalid_attrs
      assert html_response(conn, 200) =~ "New Claim"
    end
  end

  describe "edit claim" do
    setup [:create_claim]

    test "renders form for editing chosen claim", %{conn: conn, claim: claim} do
      conn = get conn, claim_path(conn, :edit, claim)
      assert html_response(conn, 200) =~ "Edit Claim"
    end
  end

  describe "update claim" do
    setup [:create_claim]

    test "redirects when data is valid", %{conn: conn, claim: claim} do
      conn = put conn, claim_path(conn, :update, claim), claim: @update_attrs
      assert redirected_to(conn) == claim_path(conn, :show, claim)

      conn = get conn, claim_path(conn, :show, claim)
      assert html_response(conn, 200) =~ "some updated state"
    end

    test "renders errors when data is invalid", %{conn: conn, claim: claim} do
      conn = put conn, claim_path(conn, :update, claim), claim: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Claim"
    end
  end

  describe "delete claim" do
    setup [:create_claim]

    test "deletes chosen claim", %{conn: conn, claim: claim} do
      conn = delete conn, claim_path(conn, :delete, claim)
      assert redirected_to(conn) == claim_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, claim_path(conn, :show, claim)
      end
    end
  end

  defp create_claim(_) do
    claim = fixture(:claim)
    {:ok, claim: claim}
  end
end
