package todo.web;

import tink.http.Response;
import todo.state.*;
import todo.ui.*;

using Lambda;
using tink.CoreApi;

class FrontController implements Root {

  final api:TodoApi;
  final dataName:String;

  public function new(api, @:inject.tag('todo.api.dataName') dataName) {
    this.api = api;
    this.dataName = dataName;
  }

  public function index():OutgoingResponse {
    return new HtmlResult(
      Pilot.html(
        <TodoState api={api} todos={api.getTodos()} status={Ready}>
          <App />
        </TodoState>
      ), 
      dataName,
      api
    ).toResponse();
  }

  public function addTodo(body) {
    return api.addTodo(body.content).next(todo -> {
      data: todo.toJson()
    });
  }

  public function updateTodo(id:Int, body) {
    return api.updateTodo(id, body.content, body.complete).next(todo -> {
      data: todo.toJson()
    });
  }

  public function removeTodo(id:Int):Promise<{ data:{ id: Int } }> {
    var todo = api.getTodos().find(t -> t.id == id);
    if (todo == null) return new Error('No todo exists with the id ${id}');
    return api.removeTodo(todo).next(todo -> {
      data: { id: todo.id }
    });
  }

}
