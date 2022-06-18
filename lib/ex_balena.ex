defmodule ExBalena do
  @moduledoc """
  The packages principal context.
  """

  @spec start() :: :ok | no_return()
  def start() do
    with {:ok, _supervisor} <- ExBalena.Supervisor.start_link() do
      :ok
    end
  end

  defmodule Device do
    @typedoc """
    ## `t:Balena.Device.uuid`
    The unique identifier for a Balena Device.
    """
    @type uuid :: String.t()
  end

  defmodule Fleet do
    alias ExBalena.API.V2

    @spec current_state(Balena.Device.uuid()) :: Tesla.Env.t()
    def current_state(uuid) do
      V2.post("/applications/state", %{uuid: uuid, method: "GET"})
    end
  end
end
