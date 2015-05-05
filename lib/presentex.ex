defmodule Source do

  @shortdoc "Provides a macro to inspect source code rather than execute it"

  @moduledoc """
  Provides a macro to inspect source code rather than execute it
  """

  @doc """
  This macro does not execute the code that is passed in, rather it returns the
  source so that it can be shown in the presentation.
  """
  defmacro code(src) do
    [code: Macro.to_string(src)]
  end
end

defmodule Presentex do

  @shortdoc "Presentex generates HTML presentations for Elixir code"

  @moduledoc """
    Presentex generates an index.html file that is the presentation for the
    slides passed in.
  """

  @doc """
  Generates the slide div element that will show the Elixir source code with
  syntax highlighting.
  """
  def div([elixir: elixir]) do
    EEx.eval_string """

    <div class="slide">
      <pre><code class="elixir">
<%= elixir %>
      </code></pre>
    </div>
    """, [elixir: elixir]
  end

  @doc """
  Generates the slide div element that will show the raw HTML.
  """
  def div([html: html]) do
    EEx.eval_string """

    <div class="slide">
      <%= html %>
    </div>
    """, [html: html]
  end

  @doc """
  Generates the slide div element that will show the source code with
  syntax highlighting.
  """
  def div([code: code, lang: lang]) do
    EEx.eval_string """

    <div class="slide">
      <pre><code class="<%= lang %>">
<%= code %>
      </code></pre>
    </div>
    """, [code: code, lang: lang]
  end

  @doc """
  Generates the slide div element that will show the Elixir source code with
  syntax highlighting.
  """
  def div([code: code]) do
    EEx.eval_string """

    <div class="slide">
      <pre><code class="elixir">
<%= code %>
      </code></pre>
    </div>
    """, [code: code]
  end

  @doc """
  Generates the slide div element that will show the title and subtitle.
  """
  def div(args = [title: title, subtitle: subtitle]) do
    EEx.eval_string """

    <div class="slide">
      <h2><%= title %></h2>
      <h5><%= subtitle %></h5>
    </div>
    """, args
  end

  @doc """
  Generates the slide div element that will show a really large title.
  """
  def div(args = [title: title]) do
    EEx.eval_string """

    <div class="slide">
      <h1 class="title"><%= title %></h1>
    </div>
    """, args
  end

  @doc """
  Generates the slide div element that will show a quote and attribute it.
  """
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

  @doc """
  Generates the slide div element that will show a paragraph of text.
  """
  def div(s) when is_binary(s) do
    EEx.eval_string """

    <div class="slide">
      <p><%= s %></p>
    </div>
    """, [s: s]
  end

  @doc """
  Generates the slide div element that will show a bulleted list of items.
  """
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

  @doc """
  Generates the content of the index.html file.
  """
  def index(slides, style \\ "tomorrow") do # other decent defaults are idea and github
    EEx.eval_string """
    <html>
    <head>
      <link rel="stylesheet" href="styles/<%= style %>.css">
      <link rel="stylesheet" href="presentex.css">

    </head>
    <body>

      <%= for slide <- slides do %>
      <%= Presentex.div(slide) %>
      <% end %>

      <script src="./highlight.pack.js"></script>
      <script>hljs.initHighlightingOnLoad();</script>
      <script src="./jquery-2.1.3.min.js"></script>
      <script src="./flowtype.js"></script>
      <script src="./presentex.js"></script>
    </body>
    </html>

    """, [slides: slides, style: style]
  end

  @doc """
  Generates the index.html file and copies the other JavaScript and CSS files
  to the destination directory.
  """
  def gen(path, slides) do
    require Source

    content = Presentex.index(slides)

    File.write!(Path.join(path, "index.html"), content)

    # File.cp_r("files", path) # for local dev/testing only
    File.cp_r("deps/presentex/files", path)
  end

end
