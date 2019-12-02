package todo.web;

import tink.http.Response;
import todo.data.Store;
import todo.ui.*;

class FrontController {

  final store:Store;

  public function new(store) {
    this.store = store;
  }

  @:get('/')
  public function index():OutgoingResponse {
    return new HtmlResult(Pilot.html(
      <StoreProvider store={store}>
        <App />
      </StoreProvider>
    ), store);
  }

}
