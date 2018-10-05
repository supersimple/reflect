defmodule ReflectWeb.MirrorChannel do
  use Phoenix.Channel

  def join("mirror:data", _message, socket) do
    {:ok, socket}
  end

  def join("mirror:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
end
