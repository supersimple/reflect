defmodule ReflectWeb.WeatherView do
  use Phoenix.LiveView

  @interval 15 * 60 * 1000

  def render(assigns) do
    ~L"""
    <div id="right-col">
      <div id="current_weather">
        <img src="<%= @current_weather[:icon] %>" class="icon" />
        <h1 class="temp"><%= @current_weather[:temperature] %></h1>
      </div>
      <ol>
        <li id="day_one_weather">
          <h2 class="high_temp"><%= @day_one_weather.max_temp %></h2>
          <h2 class="low_temp"><%= @day_one_weather.min_temp %></h2>
          <img src="images/<%= @day_one_weather.icon %>.png" class="icon" />
        </li>
        <li id="day_two_weather">
          <h2 class="high_temp"><%= @day_two_weather.max_temp %></h2>
          <h2 class="low_temp"><%= @day_two_weather.min_temp %></h2>
          <img src="images/<%= @day_two_weather.icon %>.png" class="icon" />
        </li>
        <li id="day_three_weather">
          <h2 class="high_temp"><%= @day_three_weather.max_temp %></h2>
          <h2 class="low_temp"><%= @day_three_weather.min_temp %></h2>
          <img src="images/<%= @day_three_weather.icon %>.png" class="icon" />
        </li>
        <li id="day_four_weather">
          <h2 class="high_temp"><%= @day_four_weather.max_temp %></h2>
          <h2 class="low_temp"><%= @day_four_weather.min_temp %></h2>
          <img src="images/<%= @day_four_weather.icon %>.png" class="icon" />
        </li>
        <li id="day_five_weather">
          <h2 class="high_temp"><%= @day_five_weather.max_temp %></h2>
          <h2 class="low_temp"><%= @day_five_weather.min_temp %></h2>
          <img src="images/<%= @day_five_weather.icon %>.png" class="icon" />
        </li>
        <li id="day_six_weather">
          <h2 class="high_temp"><%= @day_six_weather.max_temp %></h2>
          <h2 class="low_temp"><%= @day_six_weather.min_temp %></h2>
          <img src="images/<%= @day_six_weather.icon %>.png" class="icon" />
        </li>
      </ol>
    </div>
    """
  end

  def mount(session, socket) do
    session = Map.merge(session, weather_data())
    schedule_work()
    {:ok, assign(socket, session)}
  end

  def handle_info(:work, socket) do
    schedule_work()

    {:noreply,
     assign(
       socket,
       weather_data()
     )}
  end

  def schedule_work() do
    Process.send_after(self(), :work, @interval)
  end

  def weather_data do
    %{
      current_weather: _current_weather,
      day_one_weather: _day_one_weather,
      day_two_weather: _day_two_weather,
      day_three_weather: _day_three_weather,
      day_four_weather: _day_four_weather,
      day_five_weather: _day_five_weather,
      day_six_weather: _day_six_weather
    } = Reflect.Mirror.fetch() |> Map.from_struct()
  end
end
