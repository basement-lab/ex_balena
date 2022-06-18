defmodule ExBalena.Supervisor do
  use Supervisor

  @moduledoc """
  Add the `Supervisor` to your Application supervision tree.any()

  ```elixir
  children = [
    ...
    ExBalena.Supervisor
  ]
  ```

  or, just start it dynamically.

  ```elixir
  {:ok, _pid} = ExBalena.Supervisor.start_link()
  ```
  """

  @spec start_link(keyword()) :: Supervisor.on_start()
  def start_link(config \\ []),
    do: Supervisor.start_link(__MODULE__, config, name: __MODULE__)

  @impl true
  @spec init(keyword()) ::
          {:ok, {:supervisor.sup_flags(), [:supervisor.child_spec()]}} | :ignore
  def init(_init_arg \\ []) do
    children = [
      {Finch,
       name: ExBalena.Finch,
       pools: %{
         :default => [size: 10]
       }}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
