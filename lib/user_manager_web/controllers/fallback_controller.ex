defmodule UserManagerWeb.FallbackController do
  use UserManagerWeb, :controller
  require Logger
  alias UserManagerWeb.Views.ChangesetJSON
  alias UserManagerWeb.Views.ErrorView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, %{message: message, status_code: status}}) do
    Logger.error("Error fallback: #{inspect(message)}, Status: #{status}")

    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", %{error: message})
  end

  def call(conn, err) do
    Logger.error("Critical error fallback (Internal Server error): Err: `#{inspect(err)}, Conn`#{inspect(conn)}")

    conn
    |> put_status(:internal_server_error)
    |> put_view(ErrorJSON)
    |> render("error.json", %{error: "Internal Server Error."})
  end
end
