defmodule Board.Repo.Migrations.CreateMinutes do
  use Ecto.Migration

  def change do
    # alter table(:meetings) do
    #   add :minutes, :string
    # end

    create table(:seats) do
      add :name, :string
      timestamps()
    end

    create table(:seats_meetings) do 
      add :seat_id, references(:seats, on_delete: :delete_all), null: false
      add :meeting_id, references(:meetings, on_delete: :delete_all), null: false
    end

    alter table(:items) do 
      add :minutes, :string
      add :voice_vote, :boolean
    end

    create table (:votes) do 
      add :seat_id, references(:seats, on_delete: :delete_all), null: false
      add :item_id, references(:items, on_delete: :delete_all), null: false
      add :kind, :string, null: false
    end  
  end
end
