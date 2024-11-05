defmodule Board.SeatMeeting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seats_meetings" do
    belongs_to :seat, Board.Seat
    belongs_to :meeting, Board.Meeting
  end

  def changeset(seatmeeting, attrs) do
    seatmeeting
    |> cast(attrs, [
      :seat_id,
      :meeting_id
    ])
    |> validate_required([:seat_id, :meeting_id])
    |> unique_constraint([:seat_id, :meeting_id])
  end
end
