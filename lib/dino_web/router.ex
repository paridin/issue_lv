defmodule DinoWeb.Router do
  use DinoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DinoWeb do
    pipe_through :browser
    # if two live views renders using live_render in same app.html.eex everything works well
    get "/", PageController, :index
    # But, if you use `live/2` the first live_view rendered in `app.html.eex` in our case `Live.Header` lose their context because their assigns will be override
    # by the visited live view via `live/2` in this example is `Live.Landing`.
    live "/landing", Live.Landing
  end

  # Other scopes may use custom stacks.
  # scope "/api", DinoWeb do
  #   pipe_through :api
  # end
end
