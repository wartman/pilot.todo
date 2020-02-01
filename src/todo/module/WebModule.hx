package todo.module;

import capsule.ServiceProvider;
import capsule.Container as DiContainer;
import tink.http.Middleware;
import tink.http.Container;
import tink.http.Response;
import tink.http.Handler;
import tink.http.containers.*;
import tink.web.routing.*;
import todo.data.*;
import todo.web.*;

class WebModule implements ServiceProvider {

  public function new() {}

  public function register(container:DiContainer) {
    container.map(Root).toFactory(function (store:Store) {
      return new FrontController(store);
    }).asShared();
    container.map(Container).toFactory(function () {
      return new NodeContainer(8080);
    }).asShared();
    container.map(Handler).toFactory(function (controller:Root) {
      var router = new Router<Root>(controller);
      return req -> router.route(Context.ofRequest(req))
        .recover(OutgoingResponse.reportError);
    }).asShared();
    container.map('Array<Middleware>').toFactory(function ():Array<Middleware> {
      return [
        new tink.http.middleware.Static(
          // todo: make path configurable!
          haxe.io.Path.join([ Sys.getCwd(), 'dist/assets' ]),
          'assets'
        )
      ];
    }).asShared();
  }

}