import todo.data.Store;
import todo.ui.*;

class TodoApp {

  static function main() {
    var store = new Store({ todos: [] });
    Pilot.mount(
      Pilot.dom.getElementById('root'),
      Pilot.html(<StoreProvider store={store}>
        <App />
      </StoreProvider>)
    );
  }

}
