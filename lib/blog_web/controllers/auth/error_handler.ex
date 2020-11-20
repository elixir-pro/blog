defmodule BlogWeb.Auth.ErrorHandler do
  use BlogWeb, :controller

  def auth_error(conn, {type, _reason}, _) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, Jason.encode!(%{error: to_string(type)}))
  end
end
