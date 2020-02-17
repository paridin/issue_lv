defmodule DinoWeb.Live.Landing do
  @moduledoc """
  Landing
  """
  use DinoWeb, :live_view

  defstruct user: nil
  def render(assigns) do
    ~L"""
    Landing page
    """
  end

  def mount(_params, _session, socket) do
    IO.inspect(socket)
    socket = socket
      |> assign_new(:state, fn -> %__MODULE__{
        user: %{
          name: "User",
          email: "dev@paridin.com"
        }
      } end)
    {:ok, socket}
  end

end
