defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BlogWeb.Auth.Pipeline
  end

  scope "/api", BlogWeb do
    pipe_through [:api, :auth]

    delete "/posts/:id", PostController, :delete
    get "/posts", PostController, :index
    get "/posts/:id", PostController, :show
    put "/posts/:id/update", PostController, :update
    post "/posts", PostController, :create
  end

  scope "/api", BlogWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/session", SessionController
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: BlogWeb.Telemetry
    end
  end
end
