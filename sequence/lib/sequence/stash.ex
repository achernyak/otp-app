defmodule Sequence.Stash do
  use GenServer

  @vsn "1"

  # External API

  def start_link(current_number) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_number)
  end

  def save_value(pid, value) do
    GenServer.cast pid, {:save_value, value}
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  #GenServer implementation

  def handle_call(:get_value, _from, current_value) do
    {:reply, current_value, current_value}
  end

  def handle_cast({:save_value, value}, _current_value) do
    {:noreply, value}
  end

  def code_change("0", old_state = current_number, _extra) do
    new_state = %Sequence.Server.State{current_number: current_number, delta: 1}
  end
end
