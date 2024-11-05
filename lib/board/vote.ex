defmodule Board.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :kind, :string

    belongs_to :seat, Board.Seat
    belongs_to :item, Board.Item
  end

  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [
      :kind,
      :seat_id,
      :item_id
    ])
    |> validate_required([:kind, :seat_id, :item_id])
    |> unique_constraint([:seat_id, :item_id])
  end
end
