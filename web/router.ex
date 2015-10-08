defmodule Logs.Router do
  use Logs.Web, :router

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

  scope "/api", Logs do
    pipe_through :api
    get "/p/:nick/activity", API.PersonController, :activity
  end

  scope "/", Logs do
    pipe_through :browser # Use the default browser stack
    get "/", ChannelController, :index
    get "/:name", ChannelController, :show

    get "/p/:nick", PersonController, :show
    get "/p/:nick/activity", PersonController, :activity
  end
end
