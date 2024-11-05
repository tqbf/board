defmodule Board.Repo.Migrations.CreateMinutesIndex do
  use Ecto.Migration

  def change do
    create unique_index(:seats, [:name])
    create unique_index(:seats_meetings, [:seat_id, :meeting_id])
    create unique_index(:votes, [:seat_id, :item_id])
  end
end
