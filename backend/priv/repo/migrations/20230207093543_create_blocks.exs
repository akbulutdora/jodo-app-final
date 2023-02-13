defmodule Jodoapp.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :title, :text
      add :description, :text
      add :type, :integer, null: false
      add :completed_at, :utc_datetime_usec
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:blocks, [:user_id])
    create index(:blocks, [:completed_at])
    create index(:blocks, [:type])
  end
end
