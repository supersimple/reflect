defmodule ReflectWeb.ClockView do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div id="left-col">
      <h1 id="time"><%= @current_time %></h1>
      <h1 id="date"><%= @current_date %></h1>
    </div>
    """
  end

  def mount(session, socket) do
    session = Map.merge(session, %{current_time: "Checking...", current_date: "Checking..."})
    schedule_work()
    {:ok, assign(socket, session)}
  end

  def handle_info(:work, socket) do
    current = Timex.now(-6)
    schedule_work()

    {:noreply,
     assign(socket,
       current_time: current_time(current),
       current_date: current_date(current)
     )}
  end

  def schedule_work() do
    Process.send_after(self(), :work, 1000)
  end

  def current_date(current) do
    "#{Timex.month_shortname(current.month)} #{current.day}, #{current.year}"
  end

  def current_time(current) do
    "#{two_digit_representation(current.hour)}:#{two_digit_representation(current.minute)}:#{
      two_digit_representation(current.second)
    }"
  end

  def two_digit_representation(int) when int < 10, do: "0#{int}"
  def two_digit_representation(int), do: "#{int}"
end
