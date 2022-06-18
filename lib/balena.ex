defmodule Balena do
  @moduledoc """

  """

  @typedoc """
  For containers that include the `io.balena.features.supervisor-api` label, the  Balena Supervisor
  exposes an API that services running on the device can interface with. See documentation for
  [Supervisor API](https://www.balena.io/docs/reference/supervisor/supervisor-api/).
  """
  @type supervisor_address :: String.t()


  defmodule API do
    @moduledoc false
    @type endpoint :: String.t()
    @type body :: Tesla.Env.body()
  end
end
