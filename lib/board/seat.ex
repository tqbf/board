defmodule Board.Seat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seats" do
    field :name, :string

    timestamps()

    has_many :seats_meetings, Board.SeatMeeting
    has_many :meetings, through: [:seats_meetings, :meeting]

    has_many :votes, Board.Vote
    has_many :items, through: [:votes, :item]
  end

  def changeset(seat, attrs) do
    seat
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
