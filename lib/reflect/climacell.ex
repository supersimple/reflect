defmodule Reflect.ClimaCell do
  @moduledoc """
  Interface for the ClimaCell API
  """
  alias Reflect.{Forecast, HTTP, Realtime}

  @api_key Application.compile_env(:reflect, :climacell_api_key)
  @forecast_latitude Application.compile_env(:reflect, :latitude)
  @forecast_longitude Application.compile_env(:reflect, :longitude)
  @temp_units :f

  def forecast do
    :forecast
    |> build_url()
    |> HTTP.get()
    |> parse_response()
  end

  def current do
    :realtime
    |> build_url()
    |> HTTP.get()
    |> parse_response()
  end

  defp api_key, do: @api_key
  defp latitude, do: @forecast_latitude
  defp longitude, do: @forecast_longitude
  defp fields, do: "temp,weather_code"
  defp start_time, do: "now"

  defp end_time do
    # Create an ISO8601 formatted time for 7 days from now
    DateTime.utc_now()
    |> DateTime.add(604_800, :second)
    |> DateTime.truncate(:second)
    |> DateTime.to_iso8601()
  end

  defp temp_units do
    case @temp_units do
      units when units in [:f, :us, :farenheit] -> "us"
      _ -> "si"
    end
  end

  defp build_url(:forecast) do
    "https://api.climacell.co/v3/weather/forecast/daily" <>
      "?lat=#{latitude()}" <>
      "&lon=#{longitude()}" <>
      "&unit_system=#{temp_units()}" <>
      "&start_time=#{start_time()}" <>
      "&end_time=#{end_time()}" <>
      "&fields=#{fields()}" <>
      "&apikey=#{api_key()}"
  end

  defp build_url(:realtime) do
    "https://api.climacell.co/v3/weather/realtime" <>
      "?lat=#{latitude()}" <>
      "&lon=#{longitude()}" <>
      "&unit_system=#{temp_units()}" <>
      "&fields=#{fields()}" <>
      "&apikey=#{api_key()}"
  end

  defp parse_response({:ok, %{body: body, status: 200}}) do
    case Jason.decode!(body) do
      data when is_list(data) ->
        Enum.map(data, fn row ->
          normalized_data(row)
        end)

      data ->
        normalized_data(data)
    end
  end

  defp parse_response(_resp), do: []

  defp normalized_data(%{
         "temp" => [
           %{"min" => %{"value" => min_temp}},
           %{"max" => %{"value" => max_temp}}
         ],
         "weather_code" => %{"value" => icon}
       }),
       do: %Forecast{min_temp: min_temp, max_temp: max_temp, icon: icon}

  defp normalized_data(%{
         "temp" => %{"value" => current_temp},
         "weather_code" => %{"value" => icon}
       }),
       do: %Realtime{temp: current_temp, icon: icon}
end
