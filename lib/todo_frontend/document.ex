defmodule Todo.Document do
  @moduledoc """
  An FFI module for interacting with the document module
  in JavaScript.
  """

  use ElixirScript.FFI, global: true, name: :document

  defexternal getElementById(id)
end
