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



end
