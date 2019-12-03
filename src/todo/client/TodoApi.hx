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
    return remote.addTodo({ content: todo.content }).handle(res -> switch res {
      case Success(_): store.addTodo(todo);
      case Failure(e): trace(e);
    });
  }

  public function update(todo:Todo) {
    return remote.updateTodo(todo.id, { content: todo.content }).handle(res -> switch res {
      case Success(_): trace('ok');
      case Failure(e): trace(e);
    });
  }
  
  public function remove(todo:Todo) {
    return remote.removeTodo(todo.id).handle(res -> switch res {
      case Success(_): store.removeTodo(todo);
      case Failure(e): trace(e);
    });
  }

}
