alias Board.{Repo, Meeting, Kind, Item, Seat, SeatMeeting, Vote}
require Logger

seed_data_path = Path.join(:code.priv_dir(:board), "../all-motions-parsed.json")
{:ok, raw} = File.read(seed_data_path)
data = Jason.decode!(raw)

rx = ~r"^([A-Z]+)\. "

allItemsByNum =
  Repo.all(Meeting)
  |> Repo.preload(items: [:meeting])
  |> Enum.reduce(%{}, fn mtg, acc ->
    Enum.reduce(mtg.items, acc, fn item, acc ->
      case Regex.run(rx, item.title) do
        [_, num] ->
          Map.put(acc, "#{mtg.date}.#{num}", item)

        nil ->
          acc
      end
    end)
  end)

allItemsByID =
  Repo.all(Meeting)
  |> Repo.preload(items: [:meeting])
  |> Enum.reduce(%{}, fn mtg, acc ->
    Enum.reduce(mtg.items, acc, fn item, acc ->
      if not is_nil(item.motion_id) do
        Map.put(acc, "#{mtg.date}.#{item.motion_id}", item)
      else
        acc
      end
    end)
  end)

rxd = ~r"^[A-Z0-9]+\. +(ID|MOT|MOTION|ORD|RES) ([A-Z0-9]+-[A-Z0-9]+)"

makeSeat = fn name ->
  Repo.insert!(
    %Seat{name: name},
    on_conflict: [set: [name: name]],
    conflict_target: :name,
    returning: true
  )
end

vote = fn name, kind, item ->
  seat = makeSeat.(name)

  change =
    SeatMeeting.changeset(%SeatMeeting{}, %{seat_id: seat.id, meeting_id: item.meeting.id})

  Repo.insert(change)

  change = Vote.changeset(%Vote{}, %{seat_id: seat.id, item_id: item.id, kind: kind})
  [seat, Repo.insert(change)]
end

fixit = fn motion, item ->
  Enum.each(motion["aye"], fn name ->
    [seat, r] = vote.(name, "aye", item)
    IO.inspect([seat.name, seat.id, item.meeting.id, r])
  end)

  Enum.each(motion["nay"], fn name ->
    [seat, r] = vote.(name, "nay", item)
    IO.inspect([seat.name, seat.id, item.meeting.id, r])
  end)

  Enum.each(motion["abs"], fn name ->
    [seat, r] = vote.(name, "abs", item)
    IO.inspect([seat.name, seat.id, item.meeting.id, r])
  end)

  Enum.each(motion["rec"], fn name ->
    [seat, r] = vote.(name, "rec", item)
    IO.inspect([seat.name, seat.id, item.meeting.id, r])
  end)

  change = Item.changeset(item, %{minutes: motion["block"], voice_vote: motion["voice"]})
  r = Repo.update(change)
  IO.inspect([item.id, r])
end

Enum.each(data, fn motion ->
  if value = Regex.run(rxd, motion["block"]) do
    [_, kind, id] = value
    mk = "#{motion["date"]}.#{kind} #{id}"

    if item = Map.get(allItemsByID, mk) do
      fixit.(motion, item)
    end
  else
    k = "#{motion["date"]}.#{motion["item"]}"

    if item = Map.get(allItemsByNum, k) do
      fixit.(motion, item)
    else
      raise "#{k}"
    end
  end
end)
