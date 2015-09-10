defmodule Japanese.WordController do
  use Japanese.Web, :controller

  alias Japanese.Word

  plug :scrub_params, "word" when action in [:create, :update]

  def index(conn, _params) do
    render(conn, "word.html", word: get_todays_word)
  end

  defp get_todays_word do
    words = Repo.all(Word)
    todays_row_position = rem(length(words), get_days_since_1970)
	Enum.at(words, todays_row_position - 1)
  end

  defp get_days_since_1970 do
    {megaseconds, seconds, _} = :os.timestamp
    seconds_since_1970 = megaseconds * 1000000 + seconds
    seconds_in_day = 60 * 60 * 24
    div(seconds_since_1970, seconds_in_day)
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
