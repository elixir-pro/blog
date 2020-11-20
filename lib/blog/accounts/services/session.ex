defmodule Blog.Accounts.Services.Session do
  alias Blog.Accounts.User
  alias Blog.Repo

  def authenticate(email, password) do
    Repo.get_by(User, email: email)
    |> case do
      nil ->
        {:error, :not_found}
      user ->
        password
        |> Argon2.verify_pass(user.password_hash)
        |> if do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end
end
