defmodule Board.Meeting do
  use Ecto.Schema
  alias Board.{Item, Kind, Repo}
  import Ecto.Changeset

  schema "meetings" do
    field :date, :date
    field :length, :integer
    field :uuid, :string
    timestamps()

    has_many :items, Board.Item
    has_many :seats_meetings, Board.SeatMeeting
    has_many :seats, through: [:seats_meetings, :seat]
  end

  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:date, :length, :uuid])
    |> validate_required([:date, :length])
  end
end
