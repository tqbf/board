# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Board.Repo.insert!(%Board.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Board.Repo
alias Board.Meeting
alias Board.Kind
alias Board.Item
require Logger

seed_data_path = Path.join(:code.priv_dir(:board), "repo/seeds/classified-meetings.json")
{:ok, raw} = File.read(seed_data_path)
data = Jason.decode!(raw)

Enum.each(data, fn {k, j_mtg} ->
  {:ok, date} = DateTime.from_unix(j_mtg["t"])
  len = j_mtg["l"]
  uuid = j_mtg["uid"]

  mtg = %Meeting{
    date: DateTime.to_date(date),
    length: len,
    uuid: uuid
  }

  mtg = Repo.insert!(mtg)
  Logger.info("Inserted #{k}")

  cnt =
    Enum.reduce(j_mtg["items"], 0, fn item, acc ->
      ts = item["t"]
      length = item["l"]
      kind = item["c"]
      motion_id = item["i"]
      explanation = (item["x"] != "PROC" && item["x"]) || ""
      title = item["n"]
      uuid = item["uid"]

      it = %Item{
        ts: ts,
        length: length,
        kind: kind,
        motion_id: motion_id,
        explanation: explanation,
        title: title,
        uuid: uuid,
        meeting_id: mtg.id
      }

      Repo.insert!(it)
      acc + 1
    end)

  Logger.info("inserted #{cnt} items")
end)

Logger.info("Finished inserting meetings.")

seed_data_path = Path.join(:code.priv_dir(:board), "repo/seeds/kinds.json")
{:ok, raw} = File.read(seed_data_path)
data = Jason.decode!(raw)

Enum.each(data, fn {label, detail} ->
  k = %Kind{
    kind: label,
    detail: detail
  }

  Repo.insert!(k)
  Logger.info("Inserted #{label}")
end)
