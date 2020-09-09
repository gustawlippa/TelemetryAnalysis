defmodule Analyser.Metrics do
  @moduledoc false

  import Telemetry.Metrics

  def child_spec(_) do
    TelemetryMetricsPrometheus.child_spec(metrics: metrics())
  end

  defp metrics, do:
    [
      # Metrics from emitter
      last_value("emitter.random_number.count"),
      last_value("emitter.span.start.system_time", unit: {:native, :second}),
      counter("emitter_span_exception_sum",
        event_name: [:emitter, :span, :exception],
        measurement: :duration),
      last_value("emitter.span.exception.duration", unit: {:native, :second}),
      last_value("emitter.span.stop.duration", unit: {:native, :second}),

      # Metric from the analyser
      counter("analyser.error.detected"),

      # VM metrics
      last_value("vm.memory.total", unit: :byte),
      last_value("vm.total_run_queue_lengths.total"),
      last_value("vm.total_run_queue_lengths.cpu"),
      last_value("vm.total_run_queue_lengths.io")
    ]

end
