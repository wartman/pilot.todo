import capsule.Container;
import todo.data.Store;
import todo.ui.*;
import todo.module.*;

class TodoApp {

  #if nodejs
  
  static function main() {
    var container = new Container();
    container.use(new DataModule());
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
    container.use(new DataModule());
    var store = container.get(Store);
    Pilot.mount(
      Pilot.dom.getElementById('root'),
      Pilot.html(<StoreProvider store={store}>
        <App />
      </StoreProvider>)
    );
  }
  #end

}
