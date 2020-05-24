package todo.state;

import sys.io.File;

using Lambda;
using sys.FileSystem;
using haxe.io.Path;
using haxe.Json;
using tink.CoreApi;

class ServerTodoApi implements TodoApi {

  final path:String;
  var data:Array<{
    id:Int,
    content:String,
    complete:Bool
  }>;

  public function new(path:String) {
    this.path = path;
    if (path.exists()) {
      data = File.getContent(path).parse();
    } else {
      data = [];
    }
  }

  public function addTodo(content:String):Promise<Todo> {
    var id = data.length > 0
      ? data[ data.length - 1 ].id + 1
      : 0;
    var todo = new Todo(content, id);
    data.push(todo.toJson());
    persist(data);
    return todo;
  }

  public function updateTodo(id:Int, content:String, complete:Bool):Promise<Todo> {
    var todo = data.find(t -> t.id == id);
    if (todo == null) return new Error('No todo exists with the id ${id}');
    todo.content = content;
    todo.complete = complete;
    persist(data);
    return Todo.fromJson(todo);
  }

  public function removeTodo(todo:Todo):Promise<Todo> {
    data = data.filter(d -> d.id != todo.id);
    persist(data);
    return todo;
  }

  public function getTodos():Array<Todo> {
    return data.map(Todo.fromJson);
  }

  function persist(data:Dynamic) {
    if (!path.directory().exists()) {
      path.directory().createDirectory();
    }
    File.saveContent(path, data.stringify());
  }

}
