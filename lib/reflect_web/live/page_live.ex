defmodule ReflectWeb.PageLive do
  use ReflectWeb, :live_view

  @clock_interval 1000
  @weather_interval :timer.minutes(15)
  @timezone Application.get_env(:reflect, :timezone)

  @impl true
  def mount(_params, _session, socket) do
    start_tick()
    schedule_weather()

    socket =
      socket
      |> put_date()
      |> put_weather()

    {:ok, socket}
  end

  @impl true
  def handle_info(:tick, socket) do
    start_tick()
    {:noreply, put_date(socket)}
  end

  @impl true
  def handle_info(:weather, socket) do
    schedule_weather()
    {:noreply, put_weather(socket)}
  end

  defp put_date(socket) do
    current = Timex.now(@timezone)

    assign(
      socket,
      current_time: current_time(current),
      current_date: current_date(current),
      current_seconds: current_seconds(current)
    )
  end

  defp put_weather(socket) do
    assign(
      socket,
      weather_data: weather_data()
    )
  end

  defp start_tick do
    Process.send_after(self(), :tick, @clock_interval)
  end

  defp schedule_weather do
    Process.send_after(self(), :weather, @weather_interval)
  end

  defp current_date(current) do
    "#{Timex.month_shortname(current.month)} #{current.day}, #{current.year}"
  end

  defp current_time(current) do
    "#{two_digit_representation(current.hour)}:#{two_digit_representation(current.minute)}"
  end

  defp current_seconds(current) do
    "#{two_digit_representation(current.second)}"
  end

  defp two_digit_representation(int) when int < 10, do: "0#{int}"
  defp two_digit_representation(int), do: "#{int}"

  defp weather_data do
    Reflect.Mirror.fetch() |> Map.from_struct()
  end
end
