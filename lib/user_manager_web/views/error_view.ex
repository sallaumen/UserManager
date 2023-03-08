defmodule UserManagerWeb.Views.ErrorView do
  alias Phoenix.Controller

  def render("error.json", %{error: message}), do: %{error: message}

  def render(template, _assigns) do
    %{errors: %{detail: Controller.status_message_from_template(template)}}
  end
end
