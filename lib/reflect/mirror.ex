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

  alias Reflect.ClimaCell

  def fetch do
    current_weather = ClimaCell.current()
    future_weather = ClimaCell.forecast()

    %__MODULE__{
      current_weather: %{
        icon: "images/#{current_weather.icon}.png",
        temperature: Float.round(current_weather.temp * 1.0, 1)
      },
      day_one_weather: Enum.at(future_weather, 0),
      day_two_weather: Enum.at(future_weather, 1),
      day_three_weather: Enum.at(future_weather, 2),
      day_four_weather: Enum.at(future_weather, 3),
      day_five_weather: Enum.at(future_weather, 4),
      day_six_weather: Enum.at(future_weather, 5)
    }
  end
end
