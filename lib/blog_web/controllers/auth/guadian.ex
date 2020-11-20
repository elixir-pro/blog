defmodule BlogWeb.Auth.Guardian do
  use Guardian, otp_app: :blog

  alias Blog.Accounts.Services.Session
  alias Blog.Accounts

  def subject_for_token(user, _claims), do: {:ok, to_string(user.id)}

  def authenticate(email, password) do
    case Session.authenticate(email, password) do
      {:ok, user} ->
        create_token(user)

      _ ->
        {:error, :unauthorized}
    end
  end

  def resource_from_claims(claims),
    do:
      {:ok,
       claims["sub"]
       |> Accounts.get_user!()}

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end
