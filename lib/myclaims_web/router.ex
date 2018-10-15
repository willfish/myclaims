defmodule MyclaimsWeb.Router do
  use MyclaimsWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: false
  end

  pipeline :protected do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Coherence.Authentication.Session, protected: true)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyclaimsWeb do
    pipe_through :browser

    coherence_routes()

    get "/", PageController, :index
  end

  scope "/", MyclaimsWeb do
    pipe_through(:protected)

    coherence_routes(:protected)
    resources "/claims", ClaimController
    resources "/users", UserController
  end

  defp put_user_token(conn, _) do
    token = if Coherence.logged_in?(conn) do
      Phoenix.Token.sign(
        conn, "user id", Coherence.current_user(conn).id
      )
    else
      ""
    end

    assign(conn, :token, token)
  end
end
