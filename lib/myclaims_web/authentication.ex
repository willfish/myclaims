defmodule MyclaimsWeb.Authentication do
  @user_salt "user salt"
  @expire_after 24 * 3600

  def sign(data) do
    Phoenix.Token.sign(MyclaimsWeb.Endpoint, @user_salt, data)
  end

  def verify(token) do
    Phoenix.Token.verify(
      MyclaimsWeb.Endpoint,
      @user_salt,
      token,
      max_age: @expire_after
    )
  end
end
