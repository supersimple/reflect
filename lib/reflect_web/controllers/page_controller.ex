defmodule ReflectWeb.PageController do
  use ReflectWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
