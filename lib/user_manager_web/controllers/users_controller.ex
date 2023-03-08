defmodule UserManagerWeb.UsersController do
  use UserManagerWeb, :controller
  require Logger
  alias UserManager.Users
  alias UserManagerWeb.Controllers.ParamsConverter
  alias UserManagerWeb.Controllers.ParamsValidator

  action_fallback UserManagerWeb.FallbackController

  @list_users_api_default_limit 2

  def index(conn, %{"user_id" => user_id}) do
    with :ok <- ParamsValidator.validate_is_uuid(user_id, "user_id"),
         {:ok, user} <- Users.fetch_user_by_id(user_id) do
      render(conn, :index, user: user)
    else
      err = {:error, %{message: _, status_code: _}} -> err
      {:error, message} -> handle_errors(message)
    end
  end

  def list(conn, params) do
    with :ok <- validate_list_function_required_params(params),
         {:ok, min_number} <- ParamsConverter.try_converting_to_integer(params["min_number"], "min_number"),
         users <- Users.find_users_by_min_point(min_number, @list_users_api_default_limit) do
      render(conn, :list, users: users)
    else
      {:error, message} -> handle_errors(message)
    end
  end

  defp handle_errors(error_message),
    do: {:error, %{status_code: resolve_error_status_code(error_message), message: error_message}}

  defp resolve_error_status_code(error_message) do
    cond do
      String.contains?(error_message, "not found") -> :not_found
      String.contains?(error_message, "Invalid parameter") -> :bad_request
      # pensar nisso, se 500 ta certo
      true -> :internal_server_error
    end
  end

  defp validate_list_function_required_params(%{"min_number" => _}), do: :ok

  defp validate_list_function_required_params(_),
    do: {:error, "Invalid parameter. Missing required field `min_number`."}
end
