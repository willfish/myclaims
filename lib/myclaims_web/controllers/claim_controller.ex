defmodule MyclaimsWeb.ClaimController do
  use MyclaimsWeb, :controller

  alias Myclaims.Insurance
  alias Myclaims.Insurance.Claim

  def index(conn, _params) do
    claims = Insurance.list_claims()
    render(conn, "index.html", claims: claims)
  end

  def new(conn, _params) do
    changeset = Insurance.change_claim(%Claim{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"claim" => claim_params}) do
    case Insurance.create_claim(claim_params) do
      {:ok, claim} ->
        conn
        |> put_flash(:info, "Claim created successfully.")
        |> redirect(to: claim_path(conn, :show, claim))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    claim = Insurance.get_claim!(id)
    render(conn, "show.html", claim: claim)
  end

  def edit(conn, %{"id" => id}) do
    claim = Insurance.get_claim!(id)
    changeset = Insurance.change_claim(claim)
    render(conn, "edit.html", claim: claim, changeset: changeset)
  end

  def update(conn, %{"id" => id, "claim" => claim_params}) do
    claim = Insurance.get_claim!(id)

    case Insurance.update_claim(claim, claim_params) do
      {:ok, claim} ->
        conn
        |> put_flash(:info, "Claim updated successfully.")
        |> redirect(to: claim_path(conn, :show, claim))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", claim: claim, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    claim = Insurance.get_claim!(id)
    {:ok, _claim} = Insurance.delete_claim(claim)

    conn
    |> put_flash(:info, "Claim deleted successfully.")
    |> redirect(to: claim_path(conn, :index))
  end
end
