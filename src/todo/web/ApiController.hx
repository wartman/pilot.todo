package todo.web;

import todo.data.*;

class ApiController {

  final store:Store;

  public function new(store) {
    this.store = store;
  }

  @:get('todos')
  public function getTodos() {
    return {
      type: "store",
      data: store.toJson()
    };
  }

  // todo: this needs to be async somehow

  @:post('todo')
  @:params(content in body)
  public function addTodo(content:String) {
    store.addTodo(new Todo({ content: content }));
    var data = store.toJson();
    Res.save(data);
    return data;
  }

  @:delete('todo/$id')
  public function removeTodo(id:Int) {
    var todo = store.getTodoById(id);
    if (todo != null) store.removeTodo(todo);
    var data = store.toJson();
    Res.save(data);
    return data;
  }

}
