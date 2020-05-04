package todo.state;

import pilot.State;

class TodoState extends State {
  
  @:attribute var todos:Array<Todo>;
  @:attribute var status:SiteStatus;
  @:attribute var filter:TodoFilter = TodoFilter.FilterAll;
  @:attribute var api:TodoApi;
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

  @:transition
  public function setStatus(status:SiteStatus) {
    return { status: status };
  }

  @:transition
  public function addTodo(content:String) {
    if (status == Loading) return {};
    api.addTodo(content).handle(o -> switch o {
      case Failure(err): setStatus(Failed(err.message));
      case Success(todo): finishAddingTodo(todo);
    });
    return {
      status: Loading
    };
  }

  @:transition
  function finishAddingTodo(todo:Todo) {
    return {
      todos: todos.concat([ todo ]),
      filter: FilterAll,
      status: Ready
    };
  }

  @:transition
  public function removeTodo(todo:Todo) {
    if (status == Loading) return {};
    api.removeTodo(todo).handle(o -> switch o {
      case Failure(err): setStatus(Failed(err.message));
      case Success(todo): finishRemovingTodo(todo);
    });
    return {
      status: Loading
    };
  }

  @:transition
  function finishRemovingTodo(todo:Todo) {
    return {
      todos: todos.filter(t -> t.id != todo.id),
      status: Ready
    };
  }

  @:transition
  public function updateTodo(id:Int, content:String, complete:Bool) {
    if (status == Loading) return {};
    api.updateTodo(id, content, complete).handle(o -> switch o {
      case Failure(err): setStatus(Failed(err.message));
      case Success(todo): finishUpdatingTodo(todo);
    });
    return {
      status: Loading
    };
  }

  @:transition
  function finishUpdatingTodo(todo:Todo) {
    return {
      status: Ready
    };
  }

  public function toggleTodoComplete(todo:Todo) {
    updateTodo(todo.id, todo.content, !todo.complete);
  }

  @:transition
  public function clearCompleted() {
    // todo: persist
    return {
      todos: todos.filter(t -> !t.complete)
    };
  }

  @:transition
  public function markAllPending() {
    // todo: persist
    return {
      todos: todos.map(t -> {
        t.complete = false;
        t;
      })
    };
  }

  @:transition
  public function markAllComplete() {
    // todo: persist
    return {
      todos: todos.map(t -> {
        t.complete = true;
        t;
      })
    };
  }

  @:transition
  public function setFilter(filter:TodoFilter) {
    if (filter == this.filter) return {};
    return { filter: filter };
  }

}
