defmodule DinoWeb.PageControllerTest do
  use DinoWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "An opinionated template"
  end
end
