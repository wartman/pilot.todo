package todo.web;

import pilot.VNode;
import pilot.Root;
import tink.http.Response;
import todo.data.Store;
import todo.data.Loader;

using haxe.Json;

abstract HtmlResult(OutgoingResponse) to OutgoingResponse {

  public inline function new(vNode:VNode, store:Store) {
    var node = Pilot.dom.getElementById('root');
    var root = new Root(node);
    root.update(vNode);
    this = OutgoingResponse.blob('
      <!DOCTYPE html>
      <html>

        <head>
          <title>todos</title>
          <link href="assets/app.css" rel="stylesheet" />
          <script id="${Loader.DATA_NAME}">
            window.${Loader.DATA_NAME} = ${store.toJson().stringify()}
          </script>
        </head>

        <body>
          ${node}
          <script src="assets/app.js"></script>
        </body>

      </html>
    ', 'text/html');
  }

}
