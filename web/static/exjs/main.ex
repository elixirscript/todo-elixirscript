defmodule Main do
  use ReactUI

  defp process_event(%{} = event) do
    if event.which == 13 do
      Todo.Data.add(event.target.value)
      #JS.update(event.target, object(value: ""))
    else
      JS.console.debug(event)
    end
  end

  def initial_state() do
    []
  end

  def update(todos) do
    Agent.update(:model, fn(_) ->
      todos
    end)

    render()
  end

  def view(todos) do
    ReactUI.div do
      section id: "todoapp" do
        header id: "header" do
          h1 do
            "todos"
          end
          input [
            id: "new-todo",
            placeholder: "What needs to be done?",
            autoFocus: true,
            onKeyPress: fn(event, _) -> process_event(event) end
          ]
        end
        section id: "main" do
          ul id: "todo-list" do
            Enum.map(todos, fn(todo) ->
              {the_completed, checked} = if todo.completed do
                {"completed", "checked"}
              else
                {"", ""}
              end

              li key: todo.id, className: the_completed do
                ReactUI.div className: "view" do
                  input [
                    className: "toggle",
                    type: "checkbox",
                    checked: todo.completed,
                    onChange: fn(event) -> Todo.Data.update(todo.id, event.target.checked) end
                  ]
                  label do
                    todo.title
                  end
                  button [
                    className: "destroy",
                    onClick: fn(event, _) ->
                      Todo.Data.remove(todo.id)
                    end
                  ]
                end
              end
            end)
          end
        end
        footer id: "footer"
      end
    end
  end

  def render() do
    Agent.get(:model, fn(state) -> state end)
    |> view
    |> ReactDOM.render(:document.getElementById("app"))
  end

  def start(_, _) do
    Agent.start(&initial_state/0, [name: :model])
    render()
    Todo.Data.list()
  end

end
