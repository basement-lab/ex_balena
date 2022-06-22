defmodule ExBalena.API.V2 do
  alias ExBalena.Client

  def get(path) when is_binary(path),
    do: Client.new() |> Tesla.get("/v2" <> path) |> handle_response()

  def post(path, body) when is_binary(path) and is_map(body),
    do: Client.new() |> Tesla.post("/v2" <> path, body) |> handle_response()

  @spec handle_response(Tesla.Env.t()) :: any()
  def handle_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({:ok, %Tesla.Env{status: 404, body: body}}) do
    {:error, body}
  end

  def handle_response({:ok, %Tesla.Env{status: 502, body: body}}) do
    {:error, body}
  end

  def handle_response({:ok, res}), do: {:error, res}
  def handle_response(res), do: res
end
