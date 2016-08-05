defmodule SimpleSlack do
  use Application

  @task_supervisor SimpleSlack.Task.Supervisor

  def start(_type, _args) do
    Task.Supervisor.start_link([name: @task_supervisor])
  end

  @spec notify_text(binary, binary, map) :: :ok
  def notify_text(token, text, opts \\ %{}) do
    payload = Map.put(opts, :text, text)
    notify(token, payload)
  end

  # TODO(seizans): Retry if post fails
  @spec notify(binary, map) :: :ok
  def notify(token, payload) do
    {:ok, _pid} = Task.Supervisor.start_child(@task_supervisor, fn -> post(token, payload) end)
    :ok
  end

  @spec post(binary, map) :: :ok | {:error, HTTPoison.Response.t} | {:error, any}
  def post(token, payload) do
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
