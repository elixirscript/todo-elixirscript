defmodule Data.Http do
  use ElixirScript.FFI

  foreign fetch(url)
  foreign fetch(url, init)
  foreign stringify(data)
  foreign log(data)
end
