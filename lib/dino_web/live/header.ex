defmodule DinoWeb.Live.Header do
  @moduledoc """
  DinoWeb
  """
  require Logger
  use DinoWeb, :live_view

  defstruct title: ""
  def mount(_params, %{"title" => title}, socket) do
    Logger.info(fn -> "#{inspect(socket, pretty: true, limit: :infinity, printable_limit: :infinity)}" end)
    socket =
      socket
      |> assign_new(:state, fn -> %__MODULE__{
        title: title
      } end)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""

    <header class="flex justify-between px-4 py-2 text-white">
      <h2 class="text-lg"><%= @state.title %></h2>
      <%= link "See error.", to: Routes.live_path(@socket, DinoWeb.Live.Landing) %>
    </header>
    <p class="px-6 py-2 text-gray-900 bg-white border border-2">
    In this case, we use `:state, %__MODULE__{}` to group the local state. then when `live/2` is executed, looks like it is overriding the `Live.Header` assigns,
    which also uses :state to track the title.

    <ol class="px-6 py-2 text-gray-900 bg-white border border-2">
      <li>Notes:</li>
      <li>-> In Phoenix LiveView 0.4 it works.<li>
      <li>-> render from controller also cause same issue.</li>
    </ol>

    <pre class="p-4 text-xs bg-gray-200">
    <code>
    [info] Sent 200 in 10632ms
    [info] CONNECTED TO Phoenix.LiveView.Socket in 281µs
      Transport: :websocket
      Serializer: Phoenix.Socket.V2.JSONSerializer
      Connect Info: %{session: %{"_csrf_token" => "H2UWQWmNKapTrd2lsCpmI2La"}}
      Parameters: %{"_csrf_token" => "PVc5MigIIz8xLQURMCJDATcEXRh7U34iueley_NqzLuEBFqmDG-u2a2C", "vsn" => "2.0.0"}
    %{flash: %{}, live_view_action: nil, live_view_module: DinoWeb.Live.Header}
    [info] GET /
    [debug] Processing with DinoWeb.PageController.index/2
      Parameters: %{}
      Pipelines: [:browser]
    %{flash: %{}, live_view_action: nil, live_view_module: DinoWeb.Live.Header}
    [info] GET /landing
    [debug] Processing with Phoenix.LiveView.Plug.Elixir.DinoWeb.Live.Landing/2
      Parameters: %{}
      Pipelines: [:browser]
    %{flash: %{}, live_view_action: nil, live_view_module: DinoWeb.Live.Header}
    [info] Sent 500 in 85ms
    [error] #PID<0.1312.0> running DinoWeb.Endpoint (connection #PID<0.1311.0>, stream id 1) terminated
    Server: localhost:4000 (http)
    Request: GET /landing
    ** (exit) an exception was raised:
    ** (KeyError) key :title not found in: %DinoWeb.Live.Landing{user: %{email: "dev@paridin.com", name: "User"}}
        (dino 0.1.0) lib/dino_web/live/header.ex:22: DinoWeb.Live.Header.render/1
        (phoenix_live_view 0.7.1) lib/phoenix_live_view/utils.ex:72: Phoenix.LiveView.Utils.to_rendered/2
        (phoenix_live_view 0.7.1) lib/phoenix_live_view/static.ex:257: Phoenix.LiveView.Static.to_rendered_content_tag/4
        (phoenix_live_view 0.7.1) lib/phoenix_live_view/static.ex:129: Phoenix.LiveView.Static.render/3
        (phoenix_live_view 0.7.1) lib/phoenix_live_view/helpers.ex:165: Phoenix.LiveView.Helpers.live_render/3
        (dino 0.1.0) lib/dino_web/templates/layout/app.html.eex:17: DinoWeb.LayoutView."app.html"/1
        (phoenix 1.4.13) lib/phoenix/view.ex:410: Phoenix.View.render_to_iodata/3
        (phoenix 1.4.13) lib/phoenix/controller.ex:729: Phoenix.Controller.__put_render__/5
        (phoenix 1.4.13) lib/phoenix/controller.ex:746: Phoenix.Controller.instrument_render_and_send/4
        (phoenix 1.4.13) lib/phoenix/router.ex:288: Phoenix.Router.__call__/2
        (dino 0.1.0) lib/dino_web/endpoint.ex:1: DinoWeb.Endpoint.plug_builder_call/2
        (dino 0.1.0) lib/plug/debugger.ex:130: DinoWeb.Endpoint."call (overridable 3)"/2
        (dino 0.1.0) lib/dino_web/endpoint.ex:1: DinoWeb.Endpoint.call/2
        (phoenix 1.4.13) lib/phoenix/endpoint/cowboy2_handler.ex:42: Phoenix.Endpoint.Cowboy2Handler.init/4
        (cowboy 2.7.0) /Volumes/home/Devel/dino/deps/cowboy/src/cowboy_handler.erl:41: :cowboy_handler.execute/2
        (cowboy 2.7.0) /Volumes/home/Devel/dino/deps/cowboy/src/cowboy_stream_h.erl:320: :cowboy_stream_h.execute/3
        (cowboy 2.7.0) /Volumes/home/Devel/dino/deps/cowboy/src/cowboy_stream_h.erl:302: :cowboy_stream_h.request_process/3
        (stdlib 3.10) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
    </code>
    </pre>
    </p>
    """
  end
end
