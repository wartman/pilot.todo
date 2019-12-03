package todo.ui;

import pilot.Component;
import pilot.Children;
import pilot.Provider;
import todo.client.TodoApi;

class ApiProvider extends Component {

  public inline static final ID = 'ApiProvider';

  @:attribute var api:TodoApi;
  @:attribute var children:Children;

  override function render() return html(
    <Provider id={ID} value={api}>
      {children}
    </Provider>
  );

}
