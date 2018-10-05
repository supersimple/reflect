defmodule ReflectWeb.PageController do
  use ReflectWeb, :controller

  def index(conn, _params) do
    %{
      current_weather: current_weather,
      day_one_weather: day_one_weather,
      day_two_weather: day_two_weather,
      day_three_weather: day_three_weather,
      day_four_weather: day_four_weather,
      day_five_weather: day_five_weather,
      day_six_weather: day_six_weather
    } = Reflect.Recur.get()

    conn
    |> assign(:current_weather_icon, current_weather[:icon])
    |> assign(:current_weather_temp, current_weather[:temperature])
    |> assign(:day_one_weather_icon, day_one_weather[:icon])
    |> assign(:day_two_weather_icon, day_two_weather[:icon])
    |> assign(:day_three_weather_icon, day_three_weather[:icon])
    |> assign(:day_four_weather_icon, day_four_weather[:icon])
    |> assign(:day_five_weather_icon, day_five_weather[:icon])
    |> assign(:day_six_weather_icon, day_six_weather[:icon])
    |> assign(:day_one_weather_high_temp, day_one_weather[:high])
    |> assign(:day_one_weather_low_temp, day_one_weather[:low])
    |> assign(:day_two_weather_high_temp, day_two_weather[:high])
    |> assign(:day_two_weather_low_temp, day_two_weather[:low])
    |> assign(:day_three_weather_high_temp, day_three_weather[:high])
    |> assign(:day_three_weather_low_temp, day_three_weather[:low])
    |> assign(:day_four_weather_high_temp, day_four_weather[:high])
    |> assign(:day_four_weather_low_temp, day_four_weather[:low])
    |> assign(:day_five_weather_high_temp, day_five_weather[:high])
    |> assign(:day_five_weather_low_temp, day_five_weather[:low])
    |> assign(:day_six_weather_high_temp, day_six_weather[:high])
    |> assign(:day_six_weather_low_temp, day_six_weather[:low])
    |> render("index.html")
  end
end
