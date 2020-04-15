package todo.ui;

import pilot.Component;
import todo.data.*;

class SiteHeader extends Component {

  @:attribute(inject = StoreProvider.ID) var store:Store;

  override function render() return html(
    <header class="todo-header">
      <h1 class={css('
        position: absolute;
        top: -155px;
        width: 100%;
        font-size: 100px;
        font-weight: 100;
        text-align: center;
        color: rgba(175, 47, 47, 0.15);
        -webkit-text-rendering: optimizeLegibility;
        -moz-text-rendering: optimizeLegibility;
        text-rendering: optimizeLegibility;
      ')}>todos</h1>
      <TodoInput
        inputClass="new-todo"
        value=""
        save={ value -> store.addTodo(new Todo({ content: value })) }
      />
    </header>
  );

}
