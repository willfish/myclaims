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
alias Myclaims.Repo
alias Myclaims.Insurance.Claim

users = [
  %{name: "William Fish", email: "william.michael.fish@gmail.com", type: "EMPLOYEE"},
  %{name: "Evangelos Giataganas", email: "evangelos.giatagana@mydrivesolutions.com", type: "EMPLOYEE"},
  %{name: "Marco Moscatiello", email: "marco.moscatiello@mydrivesolutions.com", type: "EMPLOYEE"},
  %{name: "Sandy Marsh", email: "sandy@example.com", type: "CUSTOMER"},
  %{name: "Joe Armstrong", email: "joe.armstrong@example.com", type: "CUSTOMER"},
  %{name: "Jessica Maidment", email: "jessica.maidment@example.com", type: "CUSTOMER"}
]
make_models = %{
  "BMW" => ["600", "700", "i3", "1-Series", "2-Series", "New Class 1602", "3-Series", "4-Series", "3-Series GT", "New Class 1500", "5-Series", "6-Series", "501", "502"],
  "Cadillac" => ["ATS", "BLS", "Catera", "Coupe", "CT6", "CTS", "Eldorado", "ELR", "Escalade", "Series", "SRX", "XT4", "XT5", "XTS"],
  "Kia" => ["Cee", "Sephia", "Carens", "Joice", "Carnival", "Retona", "Stonic", "Niro", "Sportage"],
  "Volkswagen" => ["Santana", "Quantum", "SpaceFox", "SP2", "Saveiro"],
  "Tesla" => ["Model S"]
}
makes = Map.keys(make_models)

plates = [
  "YGD-371", "RMB-278", "GFI-125", "PTO-622", "YGY-460",
  "BJI-602", "WLG-034", "QIY-800", "GQD-242", "TFL-844",
  "NWP-386", "RWG-626", "GKL-911", "XMA-301", "WVO-658",
  "YSG-566", "KCL-704", "DYC-536", "EKX-330", "WAT-652",
  "EBP-461", "CRD-553", "OOG-994", "KMD-394", "RDO-777",
  "SWL-807", "ZID-479", "BYT-318", "WHC-316", "WSB-557",
  "NRA-755", "NMN-720", "BQE-646", "KJQ-089", "FGN-482",
  "QDM-452", "IVW-526", "MYC-483"
]
states = [
  "REPORTED", "WITH_LOSS_ADJUSTER", "WITH_LOSS_ASSESSOR", "COMPLETED"
]

seed_claim = fn(user) ->
  make_date = fn(range) ->
    range
    |> FakerElixir.Date.backward()
  end

  make = makes |> Enum.random()
  model = make_models |> Map.fetch!(make) |> Enum.random()
  attrs = %{
    coordinates: %{
      lat: FakerElixir.Number.decimal(3, 6),
      lng: FakerElixir.Number.decimal(3, 6)
    },
    metadata: %{
      vehicle_information: %{
        make: make,
        model: model,
        mileage: FakerElixir.Number.decimal(5, 2),
        last_mot_date: FakerElixir.Date.backward(100..200),
        registration: plates |> Enum.random()
      }
    },
    state: states |> Enum.random(),
    user_id: user.id,
    received: make_date.(5..10),
    occurred: make_date.(10..15),
    resolved: make_date.(3..5)
  }

  %Claim{}
  |> Claim.changeset(attrs)
  |> Repo.insert!()
end

seed_user = fn(user) ->
  user = Map.merge(%{
    password: "secret",
    password_confirmation: "secret"
  }, user)

  user = %Myclaims.Coherence.User{}
         |> Myclaims.Coherence.User.changeset(user)
         |> Myclaims.Repo.insert!

  case user.type do
    "EMPLOYEE" -> nil
    "CUSTOMER" ->
      claims_count = FakerElixir.Number.between(1..3)
      for _ <- 1..claims_count, do: seed_claim.(user)
  end
end


for user <- users, do: seed_user.(user)
