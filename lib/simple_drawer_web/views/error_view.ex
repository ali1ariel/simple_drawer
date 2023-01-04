defmodule SimpleDrawerWeb.ErrorView do
  use SimpleDrawerWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end


  def render("error_drawer_not_finished_yet.json", _assigns) do
    %{errors: %{detail: "the given drawer is not finished yet."}}
  end

  def render("error_drawer_not_found.json", _assigns) do
    %{errors: %{detail: "the given drawer is not found."}}
  end
end
