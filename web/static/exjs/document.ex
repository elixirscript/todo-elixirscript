defmodule Document do
  use ElixirScript.FFI, global: true, name: :document

  defexternal getElementById(id)
end
