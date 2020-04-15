package todo.ui;

import pilot.Component;
import todo.data.*;

class TodoItem extends Component {
  
  @:attribute(inject = StoreProvider.ID) var store:Store;
  @:attribute var todo:Todo;
  @:attribute(state) var editing:Bool = false;
  final root = css('
    position: relative;
    font-size: 24px;
    border-bottom: 1px solid #ededed;
    
    &:last-child {
      border-bottom: none;
    }

    &.editing {
      border-bottom: none;
      padding: 0;

      .edit {
        display: block;
        width: 506px;
        padding: 12px 16px;
        margin: 0 0 0 43px;
      }
    }

    label {
      word-break: break-all;
      padding: 15px 15px 15px 60px;
      display: block;
      line-height: 1.2;
      transition: color 0.4s;
    }

    &.completed label {
      color: #d9d9d9;
      text-decoration: line-through;
    }

    .destroy {
      display: none;
      position: absolute;
      top: 0;
      right: 10px;
      bottom: 0;
      width: 40px;
      height: 40px;
      margin: auto 0;
      font-size: 30px;
      color: #cc9a9a;
      margin-bottom: 11px;
      transition: color 0.2s ease-out;

      &:hover {
        color: #af5b5e;
      }

      &:after {
        content: "x";
      }

    }

    &:hover .destroy {
      display: block;
    }
  ');
  final isSyncing = css('
    opacity: 0.5;
  ');

  override function render() {
    return html(<>
      @if (editing) 
        <li 
          id={todo.id} 
          @key={(todo:Dynamic)}
          class={root + ' editing'}
        >
          <TodoInput 
            value={todo.content}
            requestClose={ () -> editing = false }
            save={value -> {
              todo.content = value;
              editing = false;
            }}
          />
      </li> else <li 
        id={Std.string(todo.id)}
        onDblClick={e -> {
          e.preventDefault();
          e.stopPropagation();
          editing = true;
        }}
        @key={(todo:Dynamic)}
        class={root}
      >
        <Toggle
          checked={todo.complete}
          onClick={e -> {
            e.stopPropagation();
            todo.complete = !todo.complete;
          }}
        />
        <label>{todo.content}</label>
        <button
          class="destroy"
          onClick={ _ -> store.removeTodo(todo) }
        ></button>
      </li>
    </>);
  }

}
