defmodule Reflect.HTTP do
  @moduledoc """
  Module to handle any http requests
  """

  def get(url) do
    case Finch.request(Finch.build(:get, url), ReflectHTTP) do
      {:ok, resp} -> {:ok, resp}
      _ -> :error
    end
  end
end
