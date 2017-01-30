defmodule Todo.Data do
    def list() do
    :window.fetch("/api/todo").then(fn(response) ->
      response.json().then(fn(todos) ->
        todos
        |> Enum.map(fn(x) -> %Todo.Models.Todo{ id: x.id, completed: x.completed, title: x.title } end)
        |> Main.update()
      end)
    end).catch(fn(err) ->
      :console.debug(err)
    end)
  end

  def add(the_title) do
    :window.fetch("/api/todo", %{
      "method" => "post",
      "headers" => %{
        "Content-type" => "application/json"
      },
      "body" => JSON.stringify(%{"title" => the_title})
    }).then(fn(response) ->
      list()
    end).catch(fn(err) ->
      :console.debug(err)
    end)
  end

  def remove(id) do
    :window.fetch("/api/todo/" <> id, %{ "method" => "delete" }).then(fn(response) ->
      list()
    end).catch(fn(err) ->
      :console.debug(err)
    end)
  end

  def update(id, completed) do
    :window.fetch("/api/todo/" <> id, %{
      "method" => "put",
      "headers" => %{
        "Content-type" => "application/json"
      },
      "body" => JSON.stringify(%{ "completed" => completed })
    }).then(fn(response) ->
      list()
    end).catch(fn(err) ->
      :console.debug(err)
    end)
  end
end
