defmodule Analyser.Application do
  @moduledoc """
  Documentation for `Analyser`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Analyser.hello()
      :world

  """
  use Application

  @impl true
  def start(_type, _args) do
    Analyser.Supervisor.start_link(name: Analyser.Supervisor)
  end
end
