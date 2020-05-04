import capsule.Container;
import todo.module.*;
#if !nodejs
  import pilot.platform.dom.Dom;
#end

class TodoApp {

  public static final DATA_NAME:String = haxe.macro.Compiler.getDefine('todo-data-name');

  #if nodejs
  
  static function main() {
    var container = new Container();
    container.use(new ApiModule(DATA_NAME));
    container.use(new WebModule());

    var handler = container.get(tink.http.Handler);
    var middlewares = container.get('Array<tink.http.Middleware>');
    
    for (m in middlewares) {
      handler = handler.applyMiddleware(m);
    }

    container.get(tink.http.Container).run(handler); 
  }

  #else

    static function main() {
      var container = new Container();
      container.use(new ApiModule(DATA_NAME));
      container.use(new UiModule());
      var node = container.get(pilot.VNode, 'todo.ui.app');
      Dom.hydrate(
        js.Browser.document.getElementById('root'),
        node
      ); 
    }
    
  #end

}
