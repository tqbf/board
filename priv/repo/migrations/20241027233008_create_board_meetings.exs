defmodule Board.Repo.Migrations.CreateBoardMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :date, :date
      add :length, :integer
      add :uuid, :string
      timestamps()
    end

    create table(:items) do 
      add :ts, :integer
      add :length, :integer
      add :kind, :string
      add :motion_id, :string
      add :explanation, :string
      add :title, :string
      add :uuid, :string

      add :meeting_id, references(:meetings, on_delete: :delete_all) 

      timestamps()
    end

    create table(:kinds) do 
      add :kind, :string
      add :detail, :string
      timestamps()
    end
  end
end
