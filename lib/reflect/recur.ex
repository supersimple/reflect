defmodule Reflect.Recur do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(_state) do
    mirror = Reflect.Mirror.fetch()
    schedule_work()
    {:ok, mirror}
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:work, _state) do
    mirror = Reflect.Mirror.fetch()
    ReflectWeb.Endpoint.broadcast("mirror:data", "new_data", mirror)
    schedule_work()
    {:noreply, mirror}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 2 * 60 * 1000)
  end
end
