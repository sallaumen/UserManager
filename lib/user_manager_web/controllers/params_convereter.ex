defmodule UserManagerWeb.Controllers.ParamsConverter do
  @spec try_converting_to_integer(value :: any(), metadata :: any()) ::
          {:ok, integer_value :: integer()} | {:error, message :: any()}
  def try_converting_to_integer(value, _param_name) when is_integer(value), do: {:ok, value}

  def try_converting_to_integer(value, param_name) when is_nil(value),
    do: {:error, "Given value `null` for parameter `#{param_name}` is not a valid integer or string integer."}

  def try_converting_to_integer(value, param_name) do
    case Integer.parse(value) do
      {numeric_limit, ""} ->
        {:ok, numeric_limit}

      _ ->
        {:error,
         "Given value `#{to_binary(value)}` for parameter `#{param_name}` is not a valid integer or string integer."}
    end
  end

  @spec to_binary(any()) :: binary()
  def to_binary(data) when is_binary(data), do: data
  def to_binary(data), do: inspect(data)
end
