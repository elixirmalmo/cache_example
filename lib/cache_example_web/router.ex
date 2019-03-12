defmodule CacheExampleWeb.Router do
  use CacheExampleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CacheExampleWeb.Plugs.ItemCache
  end

  scope "/api", CacheExampleWeb do
    pipe_through :api

    resources "/items", ItemController, except: [:new, :edit]
  end
end
