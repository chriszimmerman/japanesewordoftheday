defmodule Japanese.Repo.Migrations.CreateWord do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :kanji, :string
      add :furigana, :string
      add :romaji, :string
      add :english, :string

      timestamps
    end

  end
end
