defmodule Japanese.WordController do
  use Japanese.Web, :controller

  alias Japanese.Word

  plug :scrub_params, "word" when action in [:create, :update]

  def index(conn, _params) do
    render(conn, "word.html", word: get_todays_word)
  end

  defp get_todays_word do
  	word_count = Repo.one(from word in Word, select: count("*"))
    todays_row_position = rem(get_days_since_1970, word_count)

    Repo.one(
    	from word in Word,
			limit: 1,
			offset: ^todays_row_position
		)
  end

  defp get_days_since_1970 do
    { megaseconds, seconds, _ } = :os.timestamp
    seconds_since_1970 = megaseconds * 1000000 + seconds

    seconds_in_minute = 60
    minutes_in_hour = 60
    hours_in_day = 24
    seconds_in_day = seconds_in_minute * minutes_in_hour * hours_in_day

    div(seconds_since_1970, seconds_in_day)
  end
end
