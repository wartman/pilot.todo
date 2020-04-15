package todo.data;

import pilot.cargo.Model;

class Store implements Model {

  @:prop var todos:Array<Todo>;
  @:prop(mutable) var status:ApiStatus = ApiStatus.Ready;
  @:prop(mutable) var filter:TodoFilter = TodoFilter.FilterAll;
  @:computed var remainingTodos:Int = todos.filter(t -> !t.complete).length;
  @:computed var visibleTodos:Array<Todo> = {
    var filtered = todos.copy();
    filtered.reverse();
    return switch filter {
      case FilterAll: filtered;
      case FilterCompleted: filtered.filter(todo -> todo.complete);
      case FilterPending: filtered.filter(todo -> !todo.complete);
    }
  }
  @:computed var allCompleted:Bool = remainingTodos == 0;

  public function getTodoById(id:Int):Todo {
    for (todo in todos) {
      if (todo.id == id) return todo;
    }
    return null;
  }

  @:transition
  public function addTodo(todo:Todo) {
    return {
      todos: todos.concat([ todo ])
    };
  }

  @:transition
  public function removeTodo(todo:Todo) {
    return {
      todos: todos.filter(t -> t != todo)
    };
  }

  @:transition
  public function clearCompleted() {
    return {
      todos: todos.filter(t -> !t.complete)
    };
  }

  @:transition
  public function markAllPending() {
    return {
      todos: todos.map(t -> {
        t.complete = false;
        t;
      })
    };
  }

  @:transition
  public function markAllComplete() {
    return {
      todos: todos.map(t -> {
        t.complete = true;
        t;
      })
    };
  }

}
