defmodule Reflect.Mirror do
  defstruct [
    :current_weather,
    :day_one_weather,
    :day_two_weather,
    :day_three_weather,
    :day_four_weather,
    :day_five_weather,
    :day_six_weather
  ]

  def fetch do
    dark_jason = Application.get_env(:dark_jason, :defaults)

    {:ok, %{"currently" => currently, "daily" => %{"data" => forecast}}} =
      DarkJason.forecast(dark_jason[:latitude], dark_jason[:longitude], %DarkJason{
        exclude: "minutely,hourly"
      })

    future_weather =
      Enum.reduce(forecast, {}, fn day, acc ->
        Tuple.append(acc, %{
          icon: "images/#{day["icon"]}.png",
          high: Float.round(day["temperatureMax"] * 1.0, 1),
          low: Float.round(day["temperatureMin"] * 1.0, 1)
        })
      end)

    %__MODULE__{
      current_weather: %{
        icon: "images/#{currently["icon"]}.png",
        temperature: Float.round(currently["temperature"] * 1.0, 1)
      },
      day_one_weather: elem(future_weather, 0),
      day_two_weather: elem(future_weather, 1),
      day_three_weather: elem(future_weather, 2),
      day_four_weather: elem(future_weather, 3),
      day_five_weather: elem(future_weather, 4),
      day_six_weather: elem(future_weather, 5)
    }
  end
end
