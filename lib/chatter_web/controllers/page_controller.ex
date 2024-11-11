defmodule ChatterWeb.PageController do
  use ChatterWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  # /about/City?company=Demo
  def about(conn, %{"location" => location} = params) do
    company = params |> Map.get("company", "unknown")

    render(conn, :about, company: company, location: location)
  end
end
