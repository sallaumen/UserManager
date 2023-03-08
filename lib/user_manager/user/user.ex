defmodule UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  @updatable_fields [:points]

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          points: integer,
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :points, :integer

    timestamps()
  end

  def changeset(users, attrs) do
    users
    |> cast(attrs, @updatable_fields)
    |> validate_required(@updatable_fields)
  end
end
