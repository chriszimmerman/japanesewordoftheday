defmodule Japanese.Word do
  use Japanese.Web, :model

  schema "words" do
    field :kanji, :string
    field :furigana, :string
    field :romaji, :string
    field :english, :string

    timestamps
  end

  @required_fields ~w(kanji furigana romaji english)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
