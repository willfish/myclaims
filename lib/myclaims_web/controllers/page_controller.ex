defmodule MyclaimsWeb.PageController do
  use MyclaimsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
