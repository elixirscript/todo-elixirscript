defmodule Todo.Store do

  def start_link() do
    Agent.start_link(fn -> HashDict.new end, name: __MODULE__)
  end

  def list() do
    Agent.get(__MODULE__, fn(state) -> 
      Enum.map(Dict.to_list(state), fn({key, value}) -> 
        value 
      end) 
    end)
  end

  def add(title) do
    Agent.update(__MODULE__, fn(state) ->
      Dict.put(state, Set.size(state), %Todo.Models.Todo{ title: title, completed: false, id: Set.size(state) })
    end)
  end

  def update(id, completed) do
    Agent.update(__MODULE__, fn(state) ->
      if Dict.has_key?(state, id) do
        updated_todo = %{ Dict.get(state, id) | completed: completed }
        Dict.put(state, id, updated_todo)
      else
        state
      end
    end)
  end

  def remove(id) do
    Agent.update(__MODULE__, fn(state) ->
      if Dict.has_key?(state, id) do
        Dict.delete(state, id)
      else
        state
      end
    end)
  end
  
end
