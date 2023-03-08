defmodule UserManager.Users do
  import Ecto.Query
  alias UserManager.Repo
  alias UserManager.User

  @spec fetch_user_by_id(Ecto.UUID.t()) :: {:ok, User.t()} | {:error, String.t()}
  def fetch_user_by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, "User not found given for ID `#{id}`"}
      user -> {:ok, user}
    end
  end

  @spec find_users_by_min_point(min_point :: integer(), quantity :: integer()) :: list()
  def find_users_by_min_point(min_point, quantity) do
    query =
      from u in User,
        where: u.points > ^min_point,
        select: %{id: u.id, points: u.points},
        limit: ^quantity

    Repo.all(query)
  end

  @spec create_user(attrs :: map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_user(User.t(), attrs :: map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def update_user(%User{} = users, attrs) do
    users
    |> User.changeset(attrs)
    |> Repo.update(stale_error_field: :id)
  end
end
