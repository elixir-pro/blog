defmodule BlogWeb.SessionController do
  use BlogWeb, :controller

  alias BlogWeb.Auth.Guardian
  action_fallback BlogWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> json(%{user:
      BlogWeb.UserView.render("user.json", %{user: user}), token: token})
    end
  end
end
