defmodule ReflectWeb.ClockView do
  use Phoenix.LiveView
  
  @interval 1000

  def render(assigns) do
    ~L"""
    <div id="left-col">
      <h1 id="time"><%= @current_time %><span id="secs"><%= @current_seconds %><span></h1>
      <h1 id="date"><%= @current_date %></h1>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(@interval, self(), :tick)

    {:ok, put_date(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_date(socket)}
  end

  defp put_date(socket) do
    current = Timex.now(-7)

    assign(
      socket,
      current_time: current_time(current),
      current_date: current_date(current),
      current_seconds: current_seconds(current)
    )
  end

  def current_date(current) do
    "#{Timex.month_shortname(current.month)} #{current.day}, #{current.year}"
  end

  def current_time(current) do
    "#{two_digit_representation(current.hour)}:#{two_digit_representation(current.minute)}"
  end

  def current_seconds(current) do
    "#{two_digit_representation(current.second)}"
  end

  def two_digit_representation(int) when int < 10, do: "0#{int}"
  def two_digit_representation(int), do: "#{int}"
end
