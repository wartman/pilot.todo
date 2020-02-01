package todo.module;

import capsule.*;
import tink.web.proxy.Remote;
import tink.http.clients.JsClient;
import tink.url.Host;
import todo.web.Root;
import todo.client.TodoApi;

class ClientModule implements ServiceProvider {

  public function new() {}

  public function register(container:Container) {
    container.map('Remote<Root>').toFactory(function () {
      return new Remote<Root>(
        new JsClient(),
        new RemoteEndpoint(new Host('localhost', 8080))
      );
    }).asShared();
    container.map(TodoApi).toClass(TodoApi).asShared();
  }

}
