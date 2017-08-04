defmodule Data.Http do
  use ElixirScript.FFI

  defexternal fetch(url)
  defexternal fetch(url, init)
  defexternal stringify(data)
  defexternal log(data)
end
