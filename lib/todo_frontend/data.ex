defmodule Todo.Data do
  @moduledoc """
  This module interacts with our Todo API.
  It uses REST calls to send and receive Todos from
  the server.
  """

  def list() do
    Data.Http.fetch("/api/todo").then(fn(response) ->
      response.json()
    end).then(fn(todos) ->
        todos
      |> Enum.map(fn(x) -> %Todo.Todo{ id: x.id, completed: x.completed, title: x.title } end)
      |> Main.update()
    end).catch(fn(err) ->
      Data.Http.log(err)
    end)
  end

  def add(the_title) do
    Data.Http.fetch("/api/todo", ElixirScript.JS.map_to_object(%{
      "method" => "post",
      "headers" => %{
        "Content-type" => "application/json"
      },
      "body" => Data.Http.stringify(ElixirScript.JS.map_to_object(%{"title" => the_title}))
    })).then(fn(response) ->
      list()
    end).catch(fn(err) ->
      Data.Http.log(err)
    end)
  end

  def remove(id) do
    Data.Http.fetch("/api/todo/" <> id, ElixirScript.JS.map_to_object(%{ "method" => "delete" })).then(fn(response) ->
      list()
    end).catch(fn(err) ->
      Data.Http.log(err)
    end)
  end

  def update(id, completed) do
    Data.Http.fetch("/api/todo/" <> id, ElixirScript.JS.map_to_object(%{
      "method" => "put",
      "headers" => %{
        "Content-type" => "application/json"
      },
      "body" => Data.Http.stringify(ElixirScript.JS.map_to_object(%{ "completed" => completed }))
    })).then(fn(response) ->
      list()
    end).catch(fn(err) ->
      Data.Http.log(err)
    end)
  end
end
