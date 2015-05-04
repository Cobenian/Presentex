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

[title: "Big deal"],

[title: "Cool", subtitle: "more details"],

[blockquote: "To code, or not to code. That is a dumb question.", author: "Bryan Weber"],

["foo", "bar", "baz", "quux"],

[html: """

<div style="background-color: blue; text-align: center;">
  <h1 style="color: red;">Custom HTML</h1>
</div>

"""],
