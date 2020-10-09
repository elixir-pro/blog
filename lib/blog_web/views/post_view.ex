defmodule BlogWeb.PostView do
  use BlogWeb, :view

  def render("index.json", %{posts: posts}) do
    render_many(posts, __MODULE__, "post.json")
  end

  def render("show.json", %{post: post}) do
    render_one(post, __MODULE__, "post.json")
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      title: post.title,
      content: post.content
    }
  end
end
