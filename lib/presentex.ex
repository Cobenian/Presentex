defmodule Source do
  defmacro code(src) do
    [code: Macro.to_string(src)]
  end
end

defmodule Presentex do

  def div([elixir: elixir]) do
    EEx.eval_string """

    <div class="slide">
      <pre><code class="elixir">
      <%= elixir %>
      </code></pre>
    </div>
    """, [elixir: elixir]    
  end

  def div([html: html]) do
    EEx.eval_string """

    <div class="slide">
      <%= html %>
    </div>
    """, [html: html]
  end

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

  def gen(path, slides) do
    require Source

    content = Presentex.index(slides)

    File.write!(Path.join(path, "index.html"), content)

    File.cp_r("deps/presentex/files", path)
  end

end
