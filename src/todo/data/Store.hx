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


// class Store {

//   var todos:Array<Todo> = [];
//   final build:(store:Store)->RenderResult;
//   public var dirty = true;
//   public var filter:VisibleTodos = VisibleAll;
  
//   var _allSelected:Bool = null;
//   public var allSelected(get, never):Bool;
//   public function get_allSelected() {
//     if (_allSelected != null) return _allSelected;
//     if (visibleTodos.length == 0) {
//       _allSelected = false;
//       return _allSelected;
//     }
//     _allSelected = visibleTodos.filter(t -> !t.complete).length == 0;
//     return _allSelected;
//   }

//   var _visibleTodos:Array<Todo> = null;
//   public var visibleTodos(get, never):Array<Todo>;
//   inline function get_visibleTodos() {
//     if (_visibleTodos != null) return _visibleTodos;
//     var filtered = todos.copy();
//     filtered.reverse();
//     _visibleTodos = switch filter {
//       case VisibleAll: filtered;
//       case VisibleCompleted: filtered.filter(todo -> todo.complete);
//       case VisiblePending: filtered.filter(todo -> !todo.complete);
//     }
//     return _visibleTodos;
//   }
//   public var remainingTodos(get, never):Int;
//   inline function get_remainingTodos() return todos.filter(todo -> !todo.complete).length;

//   final root:Root;

//   public function new(build, node) {
//     this.root = new Root(node);
//     this.build = build;
//   }
  
//   public function update() {
//     _visibleTodos = null;
//     _allSelected = null;
//     root.update(build(this));
//     dirty = false;
//   }

//   public function getTodos() {
//     return todos;
//   }

//   public function addTodo(todo:Todo) {
//     todos.push(todo);
//     update();
//   }

//   public function updateTodo(todo:Todo, content:String) {
//     todo.content = content;
//     update();
//   }

//   public function removeTodo(todo:Todo) {
//     todos.remove(todo);
//     update();
//   }

//   public function setFilter(filter:VisibleTodos) {
//     this.filter = filter;
//     update();
//   }

//   public function markAllComplete() {
//     dirty = true;
//     for (todo in visibleTodos) todo.complete = true;
//     update();
//   }

//   public function markAllPending() {
//     dirty = true;
//     for (todo in visibleTodos) todo.complete = false;
//     update();
//   }

//   public function markComplete(todo:Todo) {
//     if (todo.complete) return;
//     todo.complete = true;
//     update();
//   }
  
//   public function markPending(todo:Todo) {
//     if (!todo.complete) return;
//     todo.complete = false;
//     update();
//   }

//   public function clearCompleted() {
//     var toRemove = visibleTodos.filter(t -> t.complete);
//     if (toRemove.length == 0) return;
//     for (t in toRemove) {
//       todos.remove(t);
//     }
//     update();
//   }

// }
