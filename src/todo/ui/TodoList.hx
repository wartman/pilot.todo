package todo.ui;

import pilot.Component;
import todo.state.Todo;
import todo.state.TodoState;

class TodoList extends Component {
  
  @:attribute(consume) var state:TodoState;
  @:attribute var todos:Array<Todo>;

  override function render() return html(<>
    @if (todos.length > 0) <div class={css('
      position: relative;
      z-index: 2;
      border-top: 1px solid #e6e6e6;
    ')}>
      <ToggleAll
        checked={state.allCompleted}
        id="toggle-all"
        onClick={e -> {
          switch state.allCompleted {
            case true: state.markAllPending();
            case false: state.markAllComplete();
          }
        }}
      />
      <label for="toggle-all">Toggle All</label>
      <ul class={css('
        margin: 0;
        padding: 0;
        list-style: none;
      ')}>
        @for (todo in todos)
          <TodoItem todo={todo} />
      </ul>
    </div>
  </>);

}
