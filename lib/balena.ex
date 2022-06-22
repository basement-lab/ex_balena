defmodule Balena do
  @moduledoc """

  """

  alias ExBalena.API.{V1, V2}

  @typedoc """
  For containers that include the `io.balena.features.supervisor-api` label, the  Balena Supervisor
  exposes an API that services running on the device can interface with. See documentation for
  [Supervisor API](https://www.balena.io/docs/reference/supervisor/supervisor-api/).
  """
  @type supervisor_address :: String.t()

  defmodule Device do
    @typedoc """
    ## `t:Balena.Device.uuid`
    The unique identifier for a Balena Device.
    """
    @type uuid :: String.t()
  end

  @spec current_state(Balena.Device.uuid()) :: Tesla.Env.t()
  @doc """
  """
  @doc since: "7.12"
  def current_state do
    V2.get("/applications/state")
  end

  def current_state(uuid) do
    V2.post("/applications/state", %{uuid: uuid, method: "GET"})
  end
end
