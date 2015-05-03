defmodule Source do
  defmacro code(src) do
    [code: Macro.to_string(src)]
  end
end

defmodule Presentex do

  def div([code: code]) do
    EEx.eval_string """

    <div class="slide">
      <pre><code class="elixir">
<%= code %>
      </code></pre>
    </div>
    """, [code: code]
  end

  def div(args = [title: title, subtitle: subtitle]) do
    EEx.eval_string """

    <div class="slide">
      <h1><%= title %></h1>
      <h3><%= subtitle %></h3>
    </div>
    """, args

  end

  def div(args = [title: title]) do
    EEx.eval_string """

    <div class="slide">
      <h1 class="title"><%= title %></h1>
    </div>
    """, args

  end

  def div(args = [blockquote: blockquote, author: author]) do
    EEx.eval_string """

    <div class="slide">
      <blockquote>
        <%= blockquote %>
      </blockquote>
      <div class="author"><%= author %></div>
    </div>
    """, args
  end

  def div(s) when is_binary(s) do
    EEx.eval_string """

    <div class="slide">
      <p><%= s %></p>
    </div>
    """, [s: s]
  end

  def div(items) when is_list(items) do
    EEx.eval_string """

    <div class="slide">
      <ul>
        <%= for item <- items do %>
        <li><%= item %></li>
        <% end %>
      </ul>
    </div>
    """, [items: items]
  end

  def index(slides, style \\ "idea") do
    EEx.eval_string """
    <html>
    <head>
      <link rel="stylesheet" href="styles/<%= style %>.css">
      <link rel="stylesheet" href="present.css">

    </head>
    <body>

      <%= for slide <- slides do %>
      <%= Presentex.div(slide) %>
      <% end %>

      <script src="./highlight.pack.js"></script>
      <script>hljs.initHighlightingOnLoad();</script>
      <script src="./jquery-2.1.3.min.js"></script>
      <script src="./present.js"></script>
    </body>
    </html>

    """, [slides: slides, style: style]
  end

end


defmodule Main do
  def test(path \\ "../out") do

    require Source

    slides = [

      Source.code(
        defmodule Foo do
          def bar do
            IO.puts("hi")
          end
        end
      ),

      "One awesome slide",

      [title: "Big deal"],

      [title: "Cool", subtitle: "more details"],

      [blockquote: "To code, or not to code. That is a dumb question.", author: "Bryan Weber"],

      ["foo", "bar", "baz", "quux"],

    ]

    content = Presentex.index(slides)

    IO.puts(content)

    File.write!(Path.join(path, "index.html"), content)

    File.cp_r("files", path)
  end
end
