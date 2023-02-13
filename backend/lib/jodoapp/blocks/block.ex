defmodule Jodoapp.Blocks.Block do
  use Ecto.Schema
  import Ecto.Changeset


  @derive {Jason.Encoder, only: [:id, :completed_at, :description, :title, :type]}

  schema "blocks" do
    field :completed_at, :utc_datetime_usec
    field :description, :string
    field :title, :string
    field :type, Ecto.Enum, values: [
      todo: 0,
      text: 1
    ]

    belongs_to :user, Jodoapp.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, [:title, :description, :type, :completed_at, :user_id])
    |> validate_required([:title, :type, :user_id])
    |> foreign_key_constraint(:user_id)
  end

  def update_changeset(block, attrs) do
    block
    |> cast(attrs, [:title, :description, :completed_at])
    |> validate_required([:title])
  end
end
