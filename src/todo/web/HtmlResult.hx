package todo.web;

import pilot.VNode;
import pilot.platform.server.Server;
import tink.http.Response;
import todo.data.Store;
import todo.data.Res;

using haxe.Json;

abstract HtmlResult(OutgoingResponse) to OutgoingResponse {

  public inline function new(vNode:VNode, store:Store) {
    var content = Server.renderDocument(
      Pilot.html(<>
        <title>Todos</title>
        <link href='assets/app.css' rel='stylesheet' />
        <script id={Res.DATA_NAME}>
          { 'window["' + Res.DATA_NAME + '"] = ' + store.toJson().stringify() }
        </script>
      </>),
      Pilot.html(<>
        <div id='root'>
          // // todo: leaving this blank until we add hydration back in
          // {vNode}
        </div>
        <script src='assets/app.js' />
      </>)
    );
    this = OutgoingResponse.blob(content, 'text/html');
  }

  @:to public function toResponse():OutgoingResponse {
    return this;
  }

}
