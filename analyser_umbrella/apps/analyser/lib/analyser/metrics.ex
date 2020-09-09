defmodule Analyser.Metrics do
  @moduledoc false

  import Telemetry.Metrics

  def child_spec(_) do
    TelemetryMetricsPrometheus.child_spec(metrics: metrics())
  end

  defp metrics, do:
    [
      # My metrics
      last_value("emitter.random_number.count"),

      # VM metrics
      last_value("vm.memory.total", unit: :byte),
      last_value("vm.total_run_queue_lengths.total"),
      last_value("vm.total_run_queue_lengths.cpu"),
      last_value("vm.total_run_queue_lengths.io")
    ]

end
