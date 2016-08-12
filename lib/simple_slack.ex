defmodule SimpleSlack do
  @moduledoc """
  Functions to notify slack.
  For simple text notification, just use `notify_text/2`.

  ```
  iex> token = "T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"
  iex> SimpleSlack.notify_text(token, "Ika is a sushi.")
  ```
  """

  use Application

  @task_supervisor SimpleSlack.Task.Supervisor

  def start(_type, _args) do
    Task.Supervisor.start_link([name: @task_supervisor])
  end

  @doc "Equivalent to `notify(token, Map.put(opts, :text, text))`."
  @spec notify_text(binary, binary, map) :: :ok
  def notify_text(token, text, opts \\ %{}) when is_binary(token) and is_binary(text) and is_map(opts) do
    payload = Map.put(opts, :text, text)
    notify(token, payload)
  end

  @doc """
  Notify slack by using incoming hook.
  This function sends a POST request asynchronously.
  """
  # TODO(seizans): Retry if post fails
  @spec notify(binary, map) :: :ok
  def notify(token, payload) when is_binary(token) and is_map(payload) do
    {:ok, _pid} = Task.Supervisor.start_child(@task_supervisor, fn -> sync_notify(token, payload) end)
    :ok
  end

  @doc "Equivalent to `notify(token, payload)` but blocks and returns `:ok` or `{:error, reason}`."
  @spec sync_notify(binary, map) :: :ok | {:error, HTTPoison.Response.t} | {:error, any}
  def sync_notify(token, payload) when is_binary(token) and is_map(payload) do
    uri = %URI{scheme: "https",
               host: "hooks.slack.com",
               path: Path.join("/services", token)}
    case HTTPoison.post(uri, Poison.encode!(payload)) do
      {:ok, %HTTPoison.Response{status_code: 200}} ->
        :ok
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, response}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
