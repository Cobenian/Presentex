Source.code(
  defmodule Foo do
    def bar do
      IO.puts("hi")
      IO.puts("bye")
    end
  end
),

[elixir: """

defmodule Bar do
  def baz(quux) do
    IO.puts "could not find \#{quux}"
  end
end

"""],

"One awesome slide",

[heading: "Big deal"],

[title: "Cool", subtitle: "more details"],

[blockquote: "To code, or not to code. That is a dumb question.", author: "Bryan Weber"],

["foo", "bar", "baz", "quux"],

[html: """

<div style="background-color: blue; text-align: center;">
  <h3 style="color: red;">Custom HTML</h3>
</div>

"""],

[code: """
PrepareAlarm = fun(Room) ->
  io:format("Alarm set in ~s.~n",[Room]),
  fun() -> io:format(
    "Alarm tripped in ~s! Call Batman!~n",
    [Room])
  end
end.
""", lang: "erlang"]
