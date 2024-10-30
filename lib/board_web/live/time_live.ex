defmodule Board.TimeLive do
  use Phoenix.LiveView
  alias Phoenix.LiveView.Timer

  @timer_interval 20_000

  def mount(_params, _session, socket) do
    if connected?(socket), do: schedule_tick()

    socket =
      assign(socket, :current_time, DateTime.utc_now())
      |> assign(:clicked_time, DateTime.utc_now())

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    schedule_tick()
    {:noreply, assign(socket, :current_time, DateTime.utc_now())}
  end

  def handle_event("update_time", _value, socket) do
    # Update the clicked time with the current time when the button is clicked
    {:noreply, assign(socket, :clicked_time, DateTime.utc_now())}
  end

  def render(assigns) do
    ~H"""
    <div />
    """
  end

  def renderOld(assigns) do
    ~H"""
    <div>
      <div>
        Auto-updating time: <%= @current_time |> DateTime.to_string() %>
      </div>

      <div>
        Click-updating time: <%= if @clicked_time,
          do: DateTime.to_string(@clicked_time),
          else: "Not set" %>
      </div>

      <button phx-click="update_time">Update Time</button>
    </div>
    """
  end

  defp schedule_tick do
    Process.send_after(self(), :tick, @timer_interval)
  end
end
