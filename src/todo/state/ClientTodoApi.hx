package todo.state;

import tink.web.proxy.Remote;
import todo.web.Root;

using Lambda;
using tink.CoreApi;

class ClientTodoApi implements TodoApi {
  
  final remote:Remote<Root>;
  final dataName:String;
  var data:Array<Todo>;

  public function new(remote, @:inject.tag('todo.api.dataName') dataName) {
    this.dataName = dataName;
    this.remote = remote;
    data = {
      var raw:{
        todos:Array<{ id:Int, content:String, complete:Bool }>
      } = Reflect.field(js.Browser.window, dataName);
      Reflect.deleteField(js.Browser.window, dataName);
      js.Browser.document.getElementById(dataName).remove();
      raw.todos.map(Todo.fromJson);
    };
  }

  public function addTodo(content:String):Promise<Todo> {
    return remote.addTodo({ content: content })
      .next(res -> {
        var td = new Todo(content, res.data.id);
        data.push(td);
        trace(data);
        return td;
      });
  }

  public function removeTodo(todo:Todo):Promise<Todo> {
    return remote.removeTodo(todo.id).next(_ -> {
      data.remove(todo);
      return todo;
    });
  }

  public function updateTodo(id:Int, content:String, complete:Bool):Promise<Todo> {
    return remote.updateTodo(id, { content: content, complete: complete }).next(res -> {
      var todo = data.find(t -> t.id == res.data.id);
      todo.content = content;
      todo.complete = complete;
      return todo;
    });
  }

  public function getTodos():Array<Todo> {
    return data.copy();
  }

}
