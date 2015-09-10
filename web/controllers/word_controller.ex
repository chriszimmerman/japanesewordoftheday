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
end
