defmodule Spy do
  alias Spy.Agent
  alias Spy.Key
  
  def new do
    Agent.new
  end

  def keys(%Agent{keys: keys}) do
    keys
  end

  def key(agent = %Agent{}, key = %Key{}) do
    Agent.key(agent, key)
  end
end
