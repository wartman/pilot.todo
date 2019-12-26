package todo.web;

import pilot.VNode;
import pilot.Root;
import tink.http.Response;
import todo.data.Store;
import todo.data.Res;

using haxe.Json;

abstract HtmlResult(OutgoingResponse) to OutgoingResponse {

  public inline function new(vNode:VNode, store:Store) {
    var node = Pilot.document.createElement('div');
    node.setAttribute('id', 'root');
    
    var root = new Root(node);
    root.update(vNode);

    this = OutgoingResponse.blob('
      <!DOCTYPE html>
      <html>

        <head>
          <title>todos</title>
          <link href="assets/app.css" rel="stylesheet" />
          <script id="${Res.DATA_NAME}">
            window.${Res.DATA_NAME} = ${store.toJson().stringify()}
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
