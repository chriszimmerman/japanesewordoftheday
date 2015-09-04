# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Japanese.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#

{:ok, result} = File.read "japanese_jlpt1_lite.csv"
lines = String.split(result, "\n")
purged_lines = List.delete(lines, "")
Enum.each(purged_lines, 
			fn row -> 
				[kanji, furigana, romaji, english] = String.split(row, ","); 
				Japanese.Repo.insert!(%Japanese.Word{ kanji: kanji, furigana: furigana, romaji: romaji, english: english })
			end)

