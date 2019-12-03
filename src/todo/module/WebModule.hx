package todo.module;

import tink.http.Middleware;
import tink.http.Container;
import tink.http.Response;
import tink.http.Handler;
import tink.http.containers.*;
import tink.web.routing.*;
import capsule.Module;
import todo.data.*;
import todo.web.*;

class WebModule implements Module {

  @:provide
  @:share
  function _(store:Store):Root {
    return new FrontController(store);
  }

  @:provide
  @:share
  function _():Container {
    return new NodeContainer(8080);
  }

  @:provide
  @:share
  function _(controller:Root):Handler {
    var router = new Router<Root>(controller);
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