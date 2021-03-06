defmodule Japanese.Router do
  use Japanese.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Japanese do
    pipe_through :browser # Use the default browser stack

    get "/", WordController, :index
    resources "/words", WordController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Japanese do
  #   pipe_through :api
  # end
end
