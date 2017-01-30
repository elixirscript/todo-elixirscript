defmodule Todo.Store do

  def start_link() do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def list() do
    Agent.get(__MODULE__, fn(state) ->
      Enum.map(Map.to_list(state), fn({key, value}) ->
        value
      end)
    end)
  end

  def add(title) do
    Agent.update(__MODULE__, fn(state) ->
      Map.put(state, length(Map.keys(state)), %Todo.Models.Todo{ title: title, completed: false, id: length(Map.keys(state)) })
    end)
  end

  def update(id, completed) do
    Agent.update(__MODULE__, fn(state) ->
      if Map.has_key?(state, id) do
        updated_todo = %{ Map.get(state, id) | completed: completed }
        Map.put(state, id, updated_todo)
      else
        state
      end
    end)
  end

  def remove(id) do
    Agent.update(__MODULE__, fn(state) ->
      if Map.has_key?(state, id) do
        Map.delete(state, id)
      else
        state
      end
    end)
  end

end
