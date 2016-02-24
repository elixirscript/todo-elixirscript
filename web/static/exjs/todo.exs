defmodule Todo do
  defp process_event(%KeyboardEvent{"which" => 13} = event) do
    Todo.Data.add(event.target.value)
    JS.update(event.target, "value", "")
  end

  defp process_event(%KeyboardEvent{} = event) do
    :console.debug(event)
  end

  def render(todos) do
    Html.div do
      Html.section id: "todoapp" do
        Html.header id: "header" do
          Html.h1 do
            "todos"
          end
          Html.input [
            id: "new-todo",
            placeholder: "What needs to be done?",
            autofocus: true,
            onkeypress: fn(event) -> process_event(event) end
          ]
        end
        Html.section id: "main" do
          Html.ul id: "todo-list" do
            Enum.map(todos, fn(todo) ->
              {the_completed, checked} = if todo.completed do
                {"completed", "checked"}
              else
                {"", ""}
              end

              Html.li data_id: todo.id, className: the_completed do
                Html.div className: "view" do
                  Html.input [
                    className: "toggle",
                    type: "checkbox",
                    checked: todo.completed,
                    onchange: fn(event) -> Todo.Data.update(event.target.parentElement.parentElement.data_id, event.target.checked) end
                  ]
                  Html.label do
                    todo.title
                  end
                  Html.button [
                    className: "destroy",
                    onclick: fn(event) ->
                      Todo.Data.remove(event.target.parentElement.parentElement.data_id)
                    end
                  ]
                end
              end
            end)
          end
        end
        Html.footer id: "footer"
      end
    end
  end

  def main() do
    {:ok, view} = View.start(:document.getElementById("app"), &render/1, [[]], [name: :view])
    Todo.Data.list
  end
end
