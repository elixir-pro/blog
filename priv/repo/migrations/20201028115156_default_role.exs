defmodule Blog.Repo.Migrations.DefaultRole do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string
    end
  end
end
