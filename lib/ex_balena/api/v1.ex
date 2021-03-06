defmodule ExBalena.API.V1 do
  alias ExBalena.Client

  def get(path) when is_binary(path),
    do: Client.new() |> Tesla.get("/v1" <> path)

  def post(path, body) when is_binary(path) and is_map(body),
    do: Client.new() |> Tesla.post("/v1" <> path, body)

  @spec handle_response(Tesla.Env.t()) :: any()
  def handle_response(%{status: 200} = res) do
    res
  end
end
