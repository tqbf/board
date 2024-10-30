defmodule Board.ItemLive do
  use Phoenix.LiveView
  alias Board.{Rollups}

  def mount(_params, _session, socket) do
    # if connected?(socket), do: schedule_tick()

    socket =
      assign(socket, %{items: [], kind: "Zoning"})

    socket = fetch_items(socket)

    {:ok, socket}
  end

  def handle_event("update-filter", value, socket) do
    date = String.replace(value["date"], "-0", "-")
    kk = value["classifier"]

    {:noreply,
     fetch_items(
       assign(socket, %{
         kk: kk,
         kind: value["kind"],
         date: date,
         tick: value["tick"]
       })
     )}
  end

  # def handle_info(:tick, socket) do
  #   {:noreply, assign(socket, :current_time, DateTime.utc_now())}
  # end

  # def handle_event("update_time", _value, socket) do
  #   # Update the clicked time with the current time when the button is clicked
  #   {:noreply, assign(socket, :clicked_time, DateTime.utc_now())}
  # end

  def render(assigns) do
    ~H"""
    <ul class="pt-4 list-disc" id="filtered-item-list" phx-hook="FilterHook">
      <%= for item <- assigns[:items] do %>
        <li class="mb-2">
          <span class="text-lime-600"><%= item.meeting.date %></span>
          <%= item.title %>
          <span class="text-red-800">(<%= Float.round(item.length / (60 * 60), 1) %> hours)</span>
        </li>
      <% end %>
    </ul>
    """
  end

  def fetch_items(socket) do
    classifier = Map.get(socket.assigns, :kk, "c10")

    cond do
      Map.has_key?(socket.assigns, :kind) ->
        assign(
          socket,
          :items,
          Rollups.by_kind_filter(
            socket.assigns[:kind],
            socket.assigns[:date],
            socket.assigns[:tick],
            classifier
          )
        )

      true ->
        socket
    end
  end
end
