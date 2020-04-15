package todo.ui;

import pilot.Component;
import todo.data.Todo;
import todo.data.Store;

class TodoList extends Component {
  
  @:attribute(inject = StoreProvider.ID) var store:Store;
  @:attribute var todos:Array<Todo>;

  override function render() return html(<>
    @if (todos.length > 0) <div class={css('
      position: relative;
      z-index: 2;
      border-top: 1px solid #e6e6e6;
    ')}>
      <ToggleAll
        checked={store.allCompleted}
        id="toggle-all"
        onClick={e -> {
          switch store.allCompleted {
            case true: store.markAllPending();
            case false: store.markAllComplete();
          }
        }}
      />
      <label for="toggle-all">Toggle All</label>
      <ul class={css('
        margin: 0;
        padding: 0;
        list-style: none;
      ')}>
        @for (todo in todos) {
          // note that we don't pass `store` here: instead,
          // it's injected for us by `<StoreProvider /> in a 
          // parent component.
          //
          // This is generally a bad idea, but just for illustration
          // purposes.
          <TodoItem todo={todo} />; 
        }
      </ul>
    </div>
  </>);

}
