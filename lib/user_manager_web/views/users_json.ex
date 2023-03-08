defmodule UserManagerWeb.UsersJSON do
  alias UserManager.User

  def render("index.json", %{user: user}) do
    format_user_data(user, :complete)
  end

  def render("list.json", %{users: users}) do
    Enum.map(users, fn user -> format_user_data(user, :reduced) end)
  end

  defp format_user_data(%User{} = user, :complete) do
    %{
      id: user.id,
      points: user.points,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  defp format_user_data(%User{} = user, :reduced) do
    %{
      id: user.id,
      points: user.points
    }
  end
end
