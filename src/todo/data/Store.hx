package todo.data;

import pilot.cargo.Model;

class Store implements Model {

  @:prop var todos:Array<Todo>;
  @:prop(mutable = true) var filter:VisibleTodos = VisibleTodos.VisibleAll;
  @:computed var remainingTodos:Int = todos.filter(t -> !t.complete).length;
  @:computed var visibleTodos:Array<Todo> = {
    var filtered = todos.copy();
    filtered.reverse();
    return switch filter {
      case VisibleAll: filtered;
      case VisibleCompleted: filtered.filter(todo -> todo.complete);
      case VisiblePending: filtered.filter(todo -> !todo.complete);
    }
  }
  @:computed var allCompleted:Bool = remainingTodos == 0;

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
