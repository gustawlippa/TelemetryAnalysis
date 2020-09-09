defmodule Analyser.Worker do
  @moduledoc false
  require Logger

  use GenServer

  ## API

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def handle_event([:emitter, :random_number], _measurements, _metadata, _config) do
#    Logger.info("[Line: #{metadata.where}] #{measurements.event} sent in #{measurements.count}")
:ok
  end
  def handle_event([:emitter, :span, :stop], %{:duration => duration}, _metadata, _config) when duration > (1.8 * 1000000000) do
        Logger.error("Emitted task took to long to execute! #{duration/1000000000} seconds.")
        :telemetry.execute([:analyser, :error], %{:detected => 1}, %{})
    :ok
  end
  def handle_event(event, measurements, _metadata, _config) do
    Logger.info("Event: #{Kernel.inspect(event)}, measurements: #{Kernel.inspect(measurements)}")
  end

  ## Callbacks

  @impl true
  def init(:ok) do
    :ok = :telemetry.attach_many(
      # unique handler id
      "analyser-worker-handler",
      [
        [:emitter, :random_number],
        [:emitter, :span, :start],
        [:emitter, :span, :stop],
        [:emitter, :span, :exception]
      ],

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
