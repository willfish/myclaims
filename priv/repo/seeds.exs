# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Myclaims.Repo.insert!(%Myclaims.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
users = [
  %{name: "William Fish", email: "william.michael.fish@gmail.com"},
  %{name: "Evangelos Giataganas", email: "evangelos.giatagana@mydrivesolutions.com"},
  %{name: "Marco Moscatiello", email: "marco.moscatiello@mydrivesolutions.com"},
  %{name: "Sandy Marsh", email: "sandy@example.com", type: "CUSTOMER"},
  %{name: "Joe Armstrong", email: "joe.armstrong@example.com", type: "CUSTOMER"},
  %{name: "Jessica Maidment", email: "jessica.maidment@example.com", type: "CUSTOMER"}
]

seed_user = fn(user) ->
  user = Map.merge(%{
    password: "secret",
    password_confirmation: "secret"
  }, user)

  %Myclaims.Coherence.User{}
  |> Myclaims.Coherence.User.changeset(user)
  |> Myclaims.Repo.insert!
end

for user <- users, do: seed_user.(user)
