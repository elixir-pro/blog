defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  alias Blog.Posts

  action_fallback BlogWeb.FallbackController

  def create(conn, %{"post" => post_params}) do
    with {:ok, post} <- Posts.create_post(post_params),
         do:
           conn
           |> put_status(:created)
           |> put_resp_header("location", Routes.post_path(conn, :show, post))
           |> render("show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    with {:ok, post} <- Posts.update_post(post, post_params),
         do:
           conn
           |> render("show.json", post: post)
  end

  def show(conn, %{"id" => id}) do
    conn
    |> render("show.json", post: Posts.get_post!(id))
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)

    with {:ok, _post} <- Posts.delete_post(post),
         do: send_resp(conn, :no_content, "")
  end

  def index(conn, _) do
    conn
    |> render("index.json", posts: Posts.list_posts())
  end
end
