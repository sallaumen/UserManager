defmodule UserManager.Factories.UserFactory do
  use ExMachina.Ecto, repo: UserManager.Repo
  alias UserManager.User

  def user_factory do
    %User{
      points: Enum.random(0..100)
    }
  end
end
