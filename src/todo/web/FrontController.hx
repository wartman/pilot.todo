package todo.web;

import tink.http.Response;
import todo.data.*;
import todo.ui.*;

class FrontController implements Root {

  final store:Store;

  public function new(store) {
    this.store = store;
  }

  public function index():OutgoingResponse {
    return new HtmlResult(Pilot.html(
      <StoreProvider store={store}>
        <App />
      </StoreProvider>
    ), store).toResponse();
  }

  public function addTodo(body) {
    var todo = new Todo({ content: body.content });
    store.addTodo(todo);
    Res.save(store.toJson());
    return {
      data: {
        id: todo.id
      }
    };
  }

  public function updateTodo(id:Int, body) {
    var todo = store.getTodoById(id);
    if (todo != null) todo.content = body.content;
    // else error
    var data = store.toJson();
    Res.save(data);
    return {
      data: {
        id: todo.id
      }
    };
  }

  public function removeTodo(id:Int) {
    var todo = store.getTodoById(id);
    if (todo != null) store.removeTodo(todo);
    // else error?
    var data = store.toJson();
    Res.save(data);
    return {
      data: {
        id: todo.id
      }
    };
  }

}
