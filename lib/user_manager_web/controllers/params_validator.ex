defmodule UserManagerWeb.Controllers.ParamsValidator do
  alias UserManagerWeb.Controllers.ParamsConverter

  @spec validate_is_uuid(param :: any(), param_name :: String.t()) ::
          :ok | {:error, %{status_code: atom(), message: String.t()}}
  def validate_is_uuid(param, param_name) do
    case Ecto.UUID.cast(param) do
      {:ok, _} ->
        :ok

      _ ->
        {:error,
         %{
           status_code: :bad_request,
           message:
             "Invalid parameter. `#{param_name}` has to be UUID. Given value: `#{ParamsConverter.to_binary(param)}`"
         }}
    end
  end
end
