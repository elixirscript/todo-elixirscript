defmodule Todo.Main do
  use React.HTML

  @moduledoc """
  The entry point to the Todo app's ElixirScript frontend

  It starts by adding the initial state into an Agent. This
  agent will hold the state of our application. Next, it calls
  the render function. This function is responsible for taking
  the state, passing it into the view function and then rendering
  the generated view to the DOM.

  The view function itself builds react components that make up
  our frontend. The state is passed in and the view function uses
  that to fill in whatever it needs from it.

  There is also an update function. The update function is triggered
  by dom events and updates the state inside the Agent. It then triggers
  a render to update the DOM
  """

  def start(_, _) do
    Agent.start(&initial_state/0, [name: :state])
    render()
    Todo.Data.list()
  end

  def initial_state() do
    []
  end

  def render() do
    Agent.get(:state, fn(state) -> state end)
    |> view
    |> ReactDOM.render("#app")
  end

  def view(todos) do
    React.HTML.div do
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
                React.HTML.div className: "view" do
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

  def update(todos) do
    Agent.update(:state, fn(_) ->
      todos
    end)

    render()
  end

  defp process_event(event) do
    if event.which == 13 do
      Todo.Data.add(event.target.value)
      ElixirScript.JS.mutate(event.target, "value", "")
    else
      Todo.Data.Http.log(event)
    end
  end
end
