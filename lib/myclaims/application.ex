defmodule Myclaims.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Myclaims.Repo, []),
      supervisor(MyclaimsWeb.Endpoint, []),
      supervisor(Absinthe.Subscription, [MyclaimsWeb.Endpoint]),
    ]

    opts = [strategy: :one_for_one, name: Myclaims.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    MyclaimsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
