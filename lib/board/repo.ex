defmodule Board.Repo do
  use Ecto.Repo,
    otp_app: :board,
    adapter: Ecto.Adapters.SQLite3
end
