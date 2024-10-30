defmodule Board.Rollups do
  import Ecto.Query, warn: false
  alias Board.{Meeting, Item, Kind, Repo}

  def month do
    allMeetings = Repo.all(Board.Meeting) |> Repo.preload(items: [:meeting])

    filteredMeetings =
      Enum.filter(allMeetings, fn meeting ->
        meeting.date.year >= 2015 or meeting.length > 15 * 60
      end)

    Enum.reduce(filteredMeetings, %{}, fn meeting, acc ->
      Map.update(
        acc,
        "#{meeting.date.year}-#{meeting.date.month}-1",
        meeting.items,
        fn items -> Enum.concat(meeting.items, items) end
      )
    end)
  end

  def quarter do
    allMeetings = Repo.all(Board.Meeting) |> Repo.preload(items: [:meeting])

    filteredMeetings =
      Enum.filter(allMeetings, fn meeting ->
        meeting.date.year >= 2015 or meeting.length > 15 * 60
      end)

    Enum.reduce(filteredMeetings, %{}, fn meeting, acc ->
      qmo = (trunc((meeting.date.month - 1) / 3) + 1) * 3 - 2

      Map.update(
        acc,
        "#{meeting.date.year}-#{qmo}-1",
        meeting.items,
        fn items -> Enum.concat(meeting.items, items) end
      )
    end)
  end

  def year do
    allMeetings = Repo.all(Board.Meeting) |> Repo.preload(items: [:meeting])

    filteredMeetings =
      Enum.filter(allMeetings, fn meeting ->
        meeting.date.year >= 2015 or meeting.length > 15 * 60
      end)

    Enum.reduce(filteredMeetings, %{}, fn meeting, acc ->
      Map.update(
        acc,
        "#{meeting.date.year}-1-1",
        meeting.items,
        fn items -> Enum.concat(meeting.items, items) end
      )
    end)
  end

  def all do
    allMeetings = Repo.all(Board.Meeting) |> Repo.preload(items: [:meeting])

    filteredMeetings =
      Enum.filter(allMeetings, fn meeting ->
        meeting.date.year >= 2015 or meeting.length > 15 * 60
      end)

    Enum.reduce(filteredMeetings, %{}, fn meeting, acc ->
      Map.update(
        acc,
        "#{meeting.date.year}-#{meeting.date.month}-#{meeting.date.day}",
        meeting.items,
        fn items -> Enum.concat(meeting.items, items) end
      )
    end)
  end

  def by_kind_10(kind) do
    kagg = Kind.con10()

    Repo.all(Board.Meeting)
    |> Repo.preload(items: [:meeting])
    |> Enum.filter(fn meeting ->
      meeting.date.year >= 2015 or meeting.length > 15 * 60
    end)
    |> Enum.reduce([], fn meeting, acc ->
      Enum.concat(
        Enum.filter(meeting.items, fn item ->
          kagg[String.to_existing_atom(item.kind)] == kind
        end),
        acc
      )
    end)
  end

  def by_kind_filter(kind, date, tick, "c10") do
    by_kind_filter(kind, date, tick, Kind.con10())
  end

  def by_kind_filter(kind, date, tick, "c25") do
    by_kind_filter(kind, date, tick, Kind.con25())
  end

  def by_kind_filter(kind, date, tick, kagg) do
    IO.inspect([kind, date, tick, kagg])

    meetings =
      case tick do
        "month" ->
          month()

        "quarter" ->
          quarter()

        "year" ->
          year()

        "all" ->
          all()

        nil ->
          month()
      end

    Map.get(meetings, date, [])
    |> Enum.filter(fn item ->
      kagg[String.to_existing_atom(item.kind)] == kind
    end)
    |> Enum.sort_by(& &1.length, :desc)
  end
end
