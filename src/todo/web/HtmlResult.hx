package todo.web;

import pilot.VNode;
import pilot.platform.server.Server;
import tink.http.Response;
import todo.state.TodoApi;

using haxe.Json;

abstract HtmlResult(OutgoingResponse) to OutgoingResponse {

  public inline function new(vNode:VNode, dataName:String, api:TodoApi) {
    var content = Server.renderDocument(
      Pilot.html(<>
        <title>Todos</title>
        <link href='assets/app.css' rel='stylesheet' />
        <script id={dataName}>
          { 'window["' + dataName + '"] = ' + ({
            todos: api.getTodos().map(t -> t.toJson())
          }).stringify() }
        </script>
      </>),
      Pilot.html(<>
        <div id='root'>
          {vNode}
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
