defmodule BlogWeb.ChangesetView do
  use BlogWeb, :view

  defp translate_errors(changeset),
    do:
      Ecto.Changeset.traverse_errors(
        changeset,
        &translate_error/1
      )

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end
end
