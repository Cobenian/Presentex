defmodule Mix.Tasks.Gen.Presentation do
  use Mix.Task

  @shortdoc "Generates an Elixir presentation (HTML)"

  @moduledoc """
  Mix Task for generating HTML presentations about Elixir code
  >> mix gen.presentation
  """
  def run(args) do
    require Source
  
    unless Enum.count(args) == 2 do
      Mix.raise "You must provide the directory where the presentation will be
      created and the file that contains the slide data."
    end
    [path, slide_file] = args
    unless File.dir?(path) do
      File.mkdir_p!(path)
    end
    slide_content = File.read!(slide_file)
    {slides, _ctx} = Code.eval_string("require Source\n [ #{slide_content} ]", macros: [{:Source, [:code]}])
    Presentex.gen(path, slides)
  end

end
