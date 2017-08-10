defmodule Todo.Data.Http do
  @moduledoc """
  An FFI module for fetching data in JavaScript.
  """

  use ElixirScript.FFI

  defexternal fetch(url)
  defexternal fetch(url, init)
  defexternal stringify(data)
  defexternal log(data)
end
