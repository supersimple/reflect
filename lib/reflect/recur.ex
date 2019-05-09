defmodule Reflect.Recur do
  use GenServer

  # 15 minutes
  @interval 15 * 60 * 1000

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
    IO.puts("Fetching Data")
    mirror = Reflect.Mirror.fetch()
    ReflectWeb.Endpoint.broadcast("mirror:data", "new_data", mirror)
    schedule_work()
    {:noreply, mirror}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, @interval)
  end
end
