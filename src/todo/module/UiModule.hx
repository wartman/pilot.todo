package todo.module;

import capsule.Container;
import capsule.ServiceProvider;
import pilot.VNode;
import todo.ui.App;
import todo.state.*;

class UiModule implements ServiceProvider {
  
  public function new() {}

  public function register(container:Container) {
    container.map(VNode, 'todo.ui.app').toFactory(function (
      api:TodoApi
    ) {
      return Pilot.html(
        <TodoState api={api} todos={api.getTodos()} status={Ready}>
          <App />
        </TodoState>
      );
    });
  }

}
