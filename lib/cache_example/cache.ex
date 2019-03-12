defmodule CacheExample.Cache do
  use GenServer

  def init(arg) do
    :ets.new(:cache, [
      :set,
      :protected,
      :named_table,
      {:read_concurrency, true}
    ])

    {:ok, arg}
  end

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def handle_call({:set, key, value}, _from, state) do
    result = :ets.insert(:cache, {key, value})
    {:reply, result, state}
  end

  def get(key) do
    case :ets.lookup(:cache, key) do
      [] ->
        nil

      [{_key, value}] ->
        value
    end
  end

  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end
end
