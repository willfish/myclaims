defmodule MyclaimsWeb.Coherence do
  @moduledoc false

  def view do
    quote do
      use Phoenix.View, root: "lib/myclaims_web/templates"
      # Import convenience functions from controllers

      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import MyclaimsWeb.Router.Helpers
      import MyclaimsWeb.ErrorHelpers
      import MyclaimsWeb.Gettext
      import MyclaimsWeb.Coherence.ViewHelpers
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, except: [layout_view: 2]
      use Coherence.Config
      use Timex

      import Ecto
      import Ecto.Query
      import Plug.Conn
      import MyclaimsWeb.Router.Helpers
      import MyclaimsWeb.Gettext
      import Coherence.Controller

      alias Coherence.Config
      alias Coherence.Controller

      require Redirects
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
