
  defmodule ExBalena.API.V2 do
    alias ExBalena.Client
    def get(path) when is_binary(path), do: Client.new() |> Tesla.get("/v2" <> path)
    def post(path, body) when is_binary(path) and is_map(body), do: Client.new() |> Tesla.post("/v2" <> path, body)
  end
