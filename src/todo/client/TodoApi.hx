package todo.client;

import tink.web.proxy.Remote;
import todo.data.*;
import todo.web.Root;

enum ApiState {
  Ready;
  Saving;
  Failed(e:String);
}

class TodoApi {

  final remote:Remote<Root>;
  final store:Store;

  public function new(remote, store) {
    this.remote = remote;
    this.store = store;
  }

  public function add(todo:Todo) {
    store.status = Loading;
    return remote.addTodo({ content: todo.content }).handle(res -> switch res {
      case Success(_):
        store.addTodo(todo);
        store.status = Ready;
      case Failure(e):
        store.status = Failed(e.message);
    });
  }

  public function update(todo:Todo) {
    store.status = Loading;
    return remote.updateTodo(todo.id, { content: todo.content }).handle(res -> switch res {
      case Success(_):
        store.status = Ready;
      case Failure(e):
        store.status = Failed(e.message);
    });
  }
  
  public function remove(todo:Todo) {
    store.status = Loading;
    return remote.removeTodo(todo.id).handle(res -> switch res {
      case Success(_):
        store.removeTodo(todo);
        store.status = Ready;
      case Failure(e): 
        store.status = Failed(e.message);
    });
  }

}
