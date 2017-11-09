defmodule Spy.Server do
    alias Spy.Agent
    use GenServer
    
    def start_link(_) do
        GenServer.start_link __MODULE__, [], name: __MODULE__
    end

    # GenServer methods
    def handle_call(:new, _from, agents) do
        port = Port.open({:spawn, "ssh-agent bash"}, [:binary])
        agent = %Agent{
            port: port
        }
        agent = %Agent{
            agent | 
            pid: pid(agent), 
            socket: socket(agent),
            keys: list_keys(agent)
        }

        {:reply, agent, [agent | agents]}
    end

    def handle_call(:all, _from, agents) do
        {:reply, agents, agents}
    end

    def handle_call({:keys, agent = %Agent{}}, _from, state) do
        {:reply, list_keys(agent), state}
    end

    def handle_call({:add_key, agent = %Agent{pid: pid}, path}, _from, agents) do
        add_key_file(agent, path)
        agent = %Agent{agent | keys: list_keys(agent)}

        {:reply, agent, Enum.map(agents, fn
            %Agent{pid: ^pid} -> agent
            x -> x
        end)}
    end

    def handle_cast({:stop, agent = %Agent{port: port}}, agents) do
        Port.close(port)

        {:noreply, 
            Enum.reject(agents, fn 
                %Agent{pid: pid} -> pid == agent.pid 
            end)
        }
    end

    # private api
    defp socket(%Agent{port: port}) do
        send port, {self(), {:command, "echo $SSH_AUTH_SOCK\n"}}
        receive do
            {^port, {:data, socket}} -> socket
        end |> String.trim
    end

    defp pid(%Agent{port: port}) do
        send port, {self(), {:command, "echo $SSH_AGENT_PID\n"}}
        receive do
            {^port, {:data, pid}} -> pid
        end |> String.trim
    end

    defp list_keys(%Agent{port: port}) do
        send port, {self(), {:command, "ssh-add -L\n"}}

        receive do
            {^port, {:data, "The agent has no identities.\n"}} -> []
            {^port, {:data, keys}} -> keys 
                |> String.trim 
                |> String.split("\n")
        end
    end

    defp add_key_file(%Agent{port: port}, file) do
        send port, {self(), {:command, "ssh-add #{file}\n"}}
    end
end
