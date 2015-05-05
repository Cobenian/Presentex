Presentex
=========

A HTML based presentation framework for Elixir.

Why use Presentex?

* It has very simple understandable HTML, CSS and JavaScript
* It works offline
* It has only TWO dependencies
  * jQuery
  * highlight.js
  * flowtype.js
* It has a very simple way to provide Elixir code samples
* It uses a larger default font size than most presentation frameworks
* All slides are generated from Elixir data structures


## License Information

* presentex: [LICENSE](LICENSE)
* highlight.js: https://github.com/isagalaev/highlight.js/blob/master/LICENSE
* jQuery: https://github.com/jquery/jquery/blob/master/LICENSE.txt
* flowtype.js: https://github.com/simplefocus/FlowType.JS/blob/master/LICENSE.txt

# Usage

Add the dependency to your mix.exs file:

```elixir
  defp deps do
    [{:presentex, "~> 0.0.8"}]
  end
```

Make sure that you do not use version 0.0.1, it will not work.

```text
  Do *NOT* use version 0.0.1, it is known to be buggy.
```

You can create Presentex presentations using the standard Elixir tool mix.

* Create a mix project if you don't have one already
* Create a file with the content of your slides
* Run `mix gen.presentation <output-dir> <slide-content-file>`

Then simply open the <output-dir>/index.html file in your browser. No internet
connection is required.

## Slides

The slides all belong in one file.  They are separated by commas.

View a sample slide file at [test/sample_slides.ex](test/sample_slides.ex)

The generated output of test/sample_slides.ex is also checked in under the [sample](sample) directory.

The slide types are:

### Title with subtitle

```elixir
  [title: "Elixir for noobs", subtitle: "A better way to program"]
```

### Title only

```elixir
  [title: "New Features"]
```

### Paragraph of text

```elixir
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
  tempor incididunt ut labore et dolore magna aliqua."
```

### Bullet list of items

```elixir
  ["Improved error handling", "Fixed memory leak in mysql driver",
    "Added UTF-8 support in library"]
```

### A quote

```elixir
  [blockquote: "To code, or not to code. That is a dumb question.",
    author: "Bryan Weber"]
```

### Elixir code

There are three different ways to include Elixir code.

```elixir
  Source.code(

      defmodule Ticket do
        def process(tkt, new_status) do
          tkt
          |> Workflow.Engine.status
          |> Workflow.Engine.transition new_status
        end
      end

  )
```

```elixir
  [elixir: """

  defmodule Foo do
    def bar do
      IO.puts "quux"
    end
  end

  """]
```

```elixir
  [code: """

  defmodule Foo do
    def bar do
      IO.puts "quux"
    end
  end

  """]
```

### Source Code (for languages other than Elixir)

The list of supported languages can be found at [highlight.js](http://highlightjs.readthedocs.org/en/latest/css-classes-reference.html)

```elixir
  [code: """

  PrepareAlarm = fun(Room) ->
      io:format("Alarm set in ~s.~n",[Room]),
      fun() -> io:format(
                 "Alarm tripped in ~s! Call Batman!~n",
                 [Room])
      end
  end.

  """, lang: "erlang"]
```

### Raw HTML

```html
  <div>
    <blink>We don't miss these days...</blink>
  </div>
```

## Release Notes

### 0.0.9

Changing default style from 'idea' to 'tomorrow'.

### 0.0.8

Fixing the font sizes to not be quite so large.

### 0.0.7

Fixing the css so flowtype.js actually resizes text.

### 0.0.6

Added flowtype.js for smarter font size handling.

### 0.0.5

Fixed a formatting issue with Elixir source code.

### 0.0.4

Added documentation

### 0.0.3

Added [elixir: "<source>"] slide type.

### 0.0.2

Added mix task that generates the presentation based on the slides input.

### 0.0.1

Buggy release, do NOT use this version.
