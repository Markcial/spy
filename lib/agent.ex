defmodule Spy.Agent do
    defstruct [port: nil, pid: nil, keys: nil, socket: nil]

    def new do
        GenServer.call(Spy.Server, :new)
    end

    def all do
        GenServer.call(Spy.Server, :all)
    end

    def stop(agent = %__MODULE__{}) do
        GenServer.cast(Spy.Server, {:stop, agent})
    end

    def key(agent = %__MODULE__{}, %Spy.Key{path: path}) do
        GenServer.call(Spy.Server, {:add_key, agent, path})
    end

    def keys(agent = %__MODULE__{}) do
        GenServer.call(Spy.Server, {:keys, agent})
    end
end
