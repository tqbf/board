defmodule BoardWeb.ChartController do
  use BoardWeb, :controller
  alias Board.{Meeting, Item, Kind, Repo, Rollups}
  alias BoardWeb.ChartHTML
  import Ecto.Query

  def index(conn, params) do
    # mix format is stripping out the parens that make this pipeline work

    # allMeetings = Repo.all(Meeting) |> Repo.preload(items: [:meeting])

    # filteredMeetings =
    #   Enum.filter(allMeetings, fn meeting ->
    #     meeting.date.year >= 2015 or meeting.length > 15 * 60
    #   end)

    # meetings =
    #   Enum.reduce(filteredMeetings, %{}, fn meeting, acc ->
    #     Map.update(
    #       acc,
    #       "#{meeting.date.year}-#{meeting.date.month}-1",
    #       meeting.items,
    #       fn items -> Enum.concat(meeting.items, items) end
    #     )
    #   end)

    {tick, meetings} =
      cond do
        Map.has_key?(params, "year") ->
          {"year", Rollups.year()}

        Map.has_key?(params, "quarter") ->
          {"quarter", Rollups.quarter()}

        Map.has_key?(params, "month") ->
          {"month", Rollups.month()}

        Map.has_key?(params, "all") ->
          {"all", Rollups.all()}

        true ->
          {"year", Rollups.year()}
      end

    {classifier, kindAgg} =
      cond do
        Map.has_key?(params, "c25") ->
          {"c25", Kind.con25()}

        Map.has_key?(params, "c10") ->
          {"c10", Kind.con10()}

        true ->
          {"c10", Kind.con10()}
      end

    kinds = Map.values(kindAgg) |> Enum.uniq()

    # meetings shape:
    # { "2/2020" => [ item, item, item ] } 
    # (items may span multiple meetings)

    kindHist =
      Enum.reduce(meetings, %{}, fn {date, items}, outer ->
        Map.put(
          outer,
          date,
          Enum.reduce(
            items,
            Enum.into(kinds, %{}, fn key -> {key, 0} end),
            fn item, hist ->
              k = kindAgg[String.to_existing_atom(item.kind)]
              Map.put(hist, k, hist[k] + item.length)
            end
          )
        )
      end)

    # kindHist shape:
    #  { "2/2022" => { "topic1" => 0, "topic2" => 1023 } }

    traces =
      Enum.reduce(kinds, %{}, fn kind, traceMap ->
        Map.put(
          traceMap,
          kind,
          Enum.map(kindHist, fn {date, hist} ->
            %{"date" => date, "length" => Map.get(hist, kind, 0)}
          end)
        )
      end)

    # the shape the js wants:
    # { 
    #   "topic": [
    #      {
    #        "date": "2/2020",
    #        "length": 0
    #      }
    #   ]
    # }

    render(conn, ChartHTML, "index.html", traces: traces, tick: tick, classifier: classifier)
  end

  def detail(conn, params) do
    kind = Map.get(params, "kind", "Zoning")
    date = Map.get(params, "date", "2020-1-1")
    tick = Map.get(params, "tick", "year")
    clas = Map.get(params, "class", "c10")

    date = String.replace(date, "-0", "-")
    items = Rollups.by_kind_filter(kind, date, tick, clas)

    render(conn, ChartHTML, "detail.html", items: items, kinds: kinds())
  end

  def meeting(conn, params) do
    date = Date.from_iso8601!(Map.get(params, "date", "2023-09-20"))

    meeting =
      Repo.all(from m in Meeting, where: m.date == ^date)
      |> Repo.preload(items: [:meeting])

    if Enum.empty?(meeting) do
      conn |> Plug.Conn.put_status(404) |> Plug.Conn.halt()
    else
      render(conn, ChartHTML, "meeting.html", kinds: kinds(), meeting: Enum.at(meeting, 0))
    end
  end

  defp kinds do
    Repo.all(Kind)
    |> Enum.reduce(%{}, fn kind, acc ->
      Map.put(acc, kind.kind, kind.detail)
    end)
  end
end
