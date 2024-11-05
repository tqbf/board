defmodule Board.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :ts, :integer
    field :length, :integer
    field :kind, :string
    field :motion_id, :string
    field :explanation, :string
    field :title, :string
    field :uuid, :string
    field :minutes, :string
    field :voice_vote, :boolean

    belongs_to :meeting, Board.Meeting
    has_many :votes, Board.Vote
    has_many :seats, through: [:votes, :seat]

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [
      :ts,
      :kind,
      :motion_id,
      :explanation,
      :title,
      :length,
      :uuid,
      :minutes,
      :voice_vote
    ])
    |> validate_required([:ts, :title, :length])
  end
end
