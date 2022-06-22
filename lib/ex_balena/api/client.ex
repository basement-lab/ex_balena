defmodule ExBalena.Client do
  @moduledoc """
  Implements a `t:Tesla.Client` for making calls to the Balena API.
  """

  @type from :: :host | :remote

  @spec new() :: Tesla.Client.t()
  def new do
    auth_middleware =
      if(is_container?(),
        do: {Tesla.Middleware.Query, [apikey: get_supervisor_api_key()]},
        else: {Tesla.Middleware.BearerAuth, token: token()}
      )

    middleware = [
      {Tesla.Middleware.BaseUrl, base_url()},
      {Tesla.Middleware.Headers, [{"content-type", "application/json"}]},
      auth_middleware,
      {Tesla.Middleware.JSON, []}
    ]

    Tesla.client(middleware)
  end

  @spec get_supervisor_address() :: Balena.supervisor_address() | no_return()
  @spec get_supervisor_api_key() :: String.t() | no_return()

  def get_supervisor_address do
    case System.get_env("BALENA_SUPERVISOR_ADDRESS") do
      "http://" <> _ = url -> url
      _ -> throw("the \"BALENA_SUPERVISOR_ADDRESS\" is not a valid url")
    end
  end

  def get_supervisor_api_key() do
    case System.get_env("BALENA_SUPERVISOR_API_KEY") do
      api_key when is_binary(api_key) and api_key != "" -> api_key
      _ -> throw("\"BALENA_SUPERVISOR_API_KEY\" is invalid")
    end
  end

  @spec is_container?() :: boolean()
  def is_container? do
    case System.get_env("BALENA") do
      env when env in ["1", "true"] -> true
      _ -> false
    end
  end

  @spec base_url(boolean()) :: Balena.supervisor_address()
  @spec base_url() :: Balena.supervisor_address()
  defp base_url(false), do: "https://api.balena-cloud.com/supervisor"
  defp base_url(true), do: get_supervisor_address()
  defp base_url, do: base_url(is_container?())

  @spec token() :: String.t() | no_return()
  defp token() do
    localpath = Path.expand("~/.balena/token")

    if File.exists?(localpath) do
      localpath
      |> File.read!()
      |> String.trim()
    end
  end
end
