defmodule Japanese.WordController do
  use Japanese.Web, :controller

  alias Japanese.Word

  plug :scrub_params, "word" when action in [:create, :update]

  def index(conn, _params) do
    words = Repo.all(Word)
	word = Enum.at(:random.uniform(length(words)) - 1)
    render(conn, "word.html", word: word)
  end

  def new(conn, _params) do
    changeset = Word.changeset(%Word{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"word" => word_params}) do
    changeset = Word.changeset(%Word{}, word_params)

    case Repo.insert(changeset) do
      {:ok, _word} ->
        conn
        |> put_flash(:info, "Word created successfully.")
        |> redirect(to: word_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    word = Repo.get!(Word, id)
    render(conn, "show.html", word: word)
  end

  def edit(conn, %{"id" => id}) do
    word = Repo.get!(Word, id)
    changeset = Word.changeset(word)
    render(conn, "edit.html", word: word, changeset: changeset)
  end

  def update(conn, %{"id" => id, "word" => word_params}) do
    word = Repo.get!(Word, id)
    changeset = Word.changeset(word, word_params)

    case Repo.update(changeset) do
      {:ok, word} ->
        conn
        |> put_flash(:info, "Word updated successfully.")
        |> redirect(to: word_path(conn, :show, word))
      {:error, changeset} ->
        render(conn, "edit.html", word: word, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    word = Repo.get!(Word, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(word)

    conn
    |> put_flash(:info, "Word deleted successfully.")
    |> redirect(to: word_path(conn, :index))
  end
end
