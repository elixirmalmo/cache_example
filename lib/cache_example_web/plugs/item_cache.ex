defmodule CacheExampleWeb.Plugs.ItemCache do
  import Plug.Conn

  alias CacheExample.Cache

  def init(opts) do
    opts
  end

  def call(
        %Plug.Conn{
          method: "GET",
          request_path: request_path
        } = conn,
        _opts
      ) do
    case Cache.get(request_path) do
      nil ->
        register_before_send(conn, &cache_response/1)

      value ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, value)
        |> halt()
    end
  end

  def call(conn, _opts), do: conn

  defp cache_response(
         %Plug.Conn{
           status: 200,
           resp_body: body,
           request_path: request_path
         } = conn
       ) do
    # Jason constructs the response JSON as an iolist which is
    # an efficient way of building strings, but has a lot of overhead
    # if we save it to ETS, so lets force it to a string.
    bin = :erlang.iolist_to_binary(body)
    Cache.set(request_path, bin)
    conn
  end

  defp cache_response(conn) do
    conn
  end
end
