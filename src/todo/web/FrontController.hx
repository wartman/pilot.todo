package todo.web;

import tink.http.Response;
import todo.data.Store;
import todo.ui.*;

class FrontController {

  final store:Store;

  public function new(store) {
    this.store = store;
  }

  @:inject
  @:sub('api/v1')
  public var api:ApiController;

  @:get('/')
  public function index():OutgoingResponse {
    return new HtmlResult(Pilot.html(
      <StoreProvider store={store}>
        <App />
      </StoreProvider>
    ), store);
  }

}
