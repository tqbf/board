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

    belongs_to :meeting, Board.Meeting

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:ts, :kind, :motion_id, :explanation, :title, :length, :uuid])
    |> validate_required([:ts, :title, :length])
  end
end
