defmodule DinoWeb.PageController do
  use DinoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
