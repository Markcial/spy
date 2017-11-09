
## SSH Agent management

SSH Agent management via port and bash calls.

```elixir
Spy.new
  |> Spy.key %Spy.Key{path: "/home/user/.ssh/id_ecdsa"}
  |> Spy.keys
# Outputs ["ecdsa-sha2-nistp256 AAAAE2V --- snip --- 9/DiV2E= /home/user/.ssh/id_ecdsa"]
```

Multiple ssh agent can be activated too.

```elixir
1..4 |> Enum.each( fn -> Spy.new end)

Spy.Agent.all
[%Spy.Agent{keys: [], pid: "27804", port: #Port<0.3981>,
  socket: "/tmp/ssh-g2eP9iPaBDf7/agent.27803"},
 %Spy.Agent{keys: [], pid: "27801", port: #Port<0.3980>,
  socket: "/tmp/ssh-oCBFHWD5zlNb/agent.27800"},
 %Spy.Agent{keys: [], pid: "27798", port: #Port<0.3979>,
  socket: "/tmp/ssh-wWWXCUCKaDxx/agent.27797"},
 %Spy.Agent{keys: [], pid: "27795", port: #Port<0.3978>,
  socket: "/tmp/ssh-IMkqF7fG9n5o/agent.27794"}]
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `spy` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:spy, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/spy](https://hexdocs.pm/spy).

