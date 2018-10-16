defmodule Resolvers.Accounts do
  def login(_, %{email: email, password: password}, _) do
    Myclaims.Accounts.authenticate(email, password)
  end
end
