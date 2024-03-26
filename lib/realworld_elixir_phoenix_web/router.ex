defmodule RealworldElixirPhoenixWeb.Router do
  use RealworldElixirPhoenixWeb, :router

  pipeline :api do
    plug Guardian.Plug.Pipeline,
      module: RealworldElixirPhoenix.Guardian,
      error_handler: RealworldElixirPhoenixWeb.AuthErrorHandler

    plug :accepts, ["json"]
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.VerifyHeader, scheme: "Token"
    plug Guardian.Plug.LoadResource, allow_blank: true
  end

  pipeline :check_authenticated do
  end

  pipeline :require_authenticated do
    plug Guardian.Plug.EnsureAuthenticated
  end

  # Optional Authenticated
  scope "/api", RealworldElixirPhoenixWeb do
    pipe_through [:api, :check_authenticated]

    post "/users", UserController, :create
    post "/users/login", UserController, :login

    delete "/users/all", UserController, :delete_all

    get "/articles", ArticleController, :index
    get "/articles/:slug", ArticleController, :show

    get "/tags", TagController, :index
  end

  # Required Authenticated
  scope "/api", RealworldElixirPhoenixWeb do
    pipe_through [:api, :require_authenticated]

    get "/user", UserController, :show
    put "/user", UserController, :update

    post "/articles", ArticleController, :create
    get "/articles/feed", ArticleController, :feed

    put "/articles/:slug", ArticleController, :update
    delete "/articles/:slug", ArticleController, :delete
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:realworld_elixir_phoenix, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RealworldElixirPhoenixWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
