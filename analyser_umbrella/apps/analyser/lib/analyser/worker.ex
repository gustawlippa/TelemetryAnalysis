defmodule Analyser.Worker do
  @moduledoc false
  require Logger

  use GenServer

  ## API

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def handle_event([:emitter, :random_number], measurements, metadata, _config) do
    Logger.info("[Line: #{metadata.where}] #{measurements.event} sent in #{measurements.count}")
  end

  ## Callbacks

  @impl true
  def init(:ok) do
    :ok = :telemetry.attach(
      # unique handler id
      "analyser-worker-handler",
      [:emitter, :random_number],
      &Analyser.Worker.handle_event/4,
      nil
    )
    {:ok, %{}}
  end

  @impl true
  def handle_call({:get, metric}, _from, metrics) do
    {:reply, Map.fetch(metrics, metric), metrics}
  end

  @impl true
  def handle_cast(_msg, metrics) do
    {:noreply, metrics}
  end

end
