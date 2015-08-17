defmodule Japanese.WordTest do
  use Japanese.ModelCase

  alias Japanese.Word

  @valid_attrs %{english: "some content", furigana: "some content", kanji: "some content", romaji: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Word.changeset(%Word{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Word.changeset(%Word{}, @invalid_attrs)
    refute changeset.valid?
  end
end
