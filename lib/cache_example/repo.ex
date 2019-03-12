defmodule CacheExample.Repo do
  use Ecto.Repo,
    otp_app: :cache_example,
    adapter: Ecto.Adapters.Postgres
end
