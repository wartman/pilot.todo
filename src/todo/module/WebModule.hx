package todo.module;

import tink.http.Middleware;
import todo.data.Store;
import tink.http.Container;
import tink.http.Response;
import tink.http.Handler;
import tink.http.containers.*;
import tink.web.routing.*;
import capsule.Module;
import todo.web.FrontController;

class WebModule implements Module {

  @:provide
  @:share
  var _:FrontController;

  @:provide
  @:share
  function _():Container {
    return new NodeContainer(8080);
  }

  @:provide
  @:share
  function _(controller:FrontController):Handler {
    var router = new Router<FrontController>(controller);
    return req -> router.route(Context.ofRequest(req))
        .recover(OutgoingResponse.reportError);
  }

  @:provide
  @:share
  function _():Array<Middleware> {
    return [
      new tink.http.middleware.Static(
        // todo: make path configurable!
        haxe.io.Path.join([ Sys.getCwd(), 'dist/assets' ]),
        'assets'
      )
    ];
  }

}