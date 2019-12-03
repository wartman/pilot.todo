package todo.module;

import tink.web.proxy.Remote;
import tink.http.clients.JsClient;
import tink.url.Host;
import capsule.Module;
import todo.web.Root;
import todo.client.TodoApi;

class ClientModule implements Module {

  @:provide
  @:share
  function _():Remote<Root> {
    return new Remote<Root>(
      new JsClient(),
      new RemoteEndpoint(new Host('localhost', 8080))
    );
  }

  @:provide
  @:share
  var _:TodoApi;

}
