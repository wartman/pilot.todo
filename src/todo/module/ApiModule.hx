package todo.module;

import capsule.Container;
import capsule.ServiceProvider;
import todo.state.TodoApi;
#if nodejs
  import todo.state.ServerTodoApi;
  
  using haxe.io.Path;
#else
  import tink.web.proxy.Remote;
  import tink.http.clients.JsClient;
  import tink.url.Host;
  import todo.web.Root;
  import todo.state.ClientTodoApi;
#end

class ApiModule implements ServiceProvider {
  
  final id:String;

  public function new(id) {
    this.id = id;
  }

  public function register(container:Container) {
    container.map(String, 'todo.api.dataName').toValue(id);
    #if nodejs
      container.map(TodoApi).toFactory(function () {
        return new ServerTodoApi(
          Path.join([ Sys.programPath().directory(), '/res/data.json' ])
        );
      });
    #else
      container.map('Remote<Root>').toFactory(function () {
        return new Remote<Root>(
          new JsClient(),
          new RemoteEndpoint(new Host('localhost', 8080))
        );
      }).asShared();
      container.map(TodoApi).toClass(ClientTodoApi);
    #end
  }

}
