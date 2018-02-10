ExUnit.start()
ESpec.start()
ESpec.Output.start

ESpec.configure fn(config) ->
  config.silent true
end

path = Path.expand("../tmp/beams", __DIR__)
File.rm_rf!(path)
File.mkdir_p!(path)
Code.prepend_path(path)

defmodule ExUnit.TestHelpers do
  def write_beam({:module, name, bin, _} = res) do
    beam_path = Path.join(unquote(path), Atom.to_string(name) <> ".beam")
    File.write!(beam_path, bin)
    res
  end
end
