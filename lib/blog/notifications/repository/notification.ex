defmodule Blog.Notifications.Repository.Notification do

  @collection "user_notification"
  defp mongo_config do
    url = Application.get_env(:blog, :mongo_db)[:url]
    {:ok, conn} = Mongo.start_link(url: url)
    conn
  end

  def send(notification) do
    mongo_config()
    |> Mongo.insert_one(@collection, notification)
  end

  def get_notification(id) do
    mongo_config()
    |> Mongo.find(@collection, %{"user_id" => id})
    |> Enum.to_list()
  end
end
