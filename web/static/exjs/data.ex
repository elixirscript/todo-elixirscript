defmodule Todo.Data do
    def list() do
    JS.fetch("/api/todo").then(fn(response) ->
      response.json()
    end).then(fn(todos) ->
        todos
      |> Enum.map(fn(x) -> %Todo.Models.Todo{ id: x.id, completed: x.completed, title: x.title } end)
      |> Main.update()
    end).catch(fn(err) ->
      :console.debug(err)
    end)
  end

  def add(the_title) do
    JS.fetch("/api/todo", %{
      "method" => "post",
      "headers" => %{
        "Content-type" => "application/json"
      },
      "body" => JS.JSON.stringify(%{"title" => the_title})
    }).then(fn(response) ->
      list()
    end).catch(fn(err) ->
      JS.console.debug(err)
    end)
  end

  def remove(id) do
    JS.fetch("/api/todo/" <> id, %{ "method" => "delete" }).then(fn(response) ->
      list()
    end).catch(fn(err) ->
      JS.console.debug(err)
    end)
  end

  def update(id, completed) do
    JS.fetch("/api/todo/" <> id, %{
      "method" => "put",
      "headers" => %{
        "Content-type" => "application/json"
      },
      "body" => JS.JSON.stringify(%{ "completed" => completed })
    }).then(fn(response) ->
      list()
    end).catch(fn(err) ->
      JS.console.debug(err)
    end)
  end
end
