defmodule ReflectWeb.Router do
  use ReflectWeb, :router
  use Plug.ErrorHandler

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ReflectWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stacktrace}) do
    conn = maybe_fetch_params(conn)
    url = "#{conn.scheme}://#{conn.host}:#{conn.port}#{conn.request_path}"
    user_ip = conn.remote_ip |> :inet.ntoa() |> List.to_string()
    headers = conn.req_headers |> Map.new()
    params = conn.params
    endpoint_url = ReflectWeb.Endpoint.config(:url)

    conn_data = %{
      "request" => %{
        "url" => url,
        "user_ip" => user_ip,
        "headers" => headers,
        "params" => params,
        "method" => conn.method
      },
      "server" => %{
        "host" => endpoint_url[:host],
        "root" => endpoint_url[:path]
      }
    }

    Rollbax.report(kind, reason, stacktrace, %{}, conn_data)
  end

  defp maybe_fetch_params(conn) do
    try do
      Plug.Conn.fetch_query_params(conn)
    rescue
      _ ->
        %{conn | params: "[UNFETCHED]"}
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReflectWeb do
  #   pipe_through :api
  # end
end
