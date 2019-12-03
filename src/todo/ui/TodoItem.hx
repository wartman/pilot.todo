package todo.ui;

import pilot.Component;
#if !nodejs
  import todo.client.TodoApi;
#end
import todo.data.*;

class TodoItem extends Component {
  
  @:attribute var todo:Todo;
  // @:attribute(inject = StoreProvider.ID) var store:Store;
  #if !nodejs
    @:attribute(inject = ApiProvider.ID) var api:TodoApi;
  #end
  @:attribute(mutable = true) var editing:Bool = false;
  @:style var root = '
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
  ';

  override function render() return html(
    <if {editing}>
      <li 
        id={Std.string(todo.id)} 
        key={todo}
        class={root + ' editing'}
      >
        <TodoInput 
          value={todo.content}
          requestClose={ () -> editing = false }
          save={value -> {
            todo.content = value;
            #if !nodejs
              api.update(todo);
            #end
            editing = false;
          }}
        />
      </li>
    <else>
      <li 
        id={Std.string(todo.id)}
        onDblClick={e -> {
          e.preventDefault();
          e.stopPropagation();
          editing = true;
        }}
        key={todo}
        class={root}
      >
        <Toggle
          checked={todo.complete}
          onClick={_ -> todo.complete = !todo.complete}
        />
        <label>{todo.content}</label>
        <button
          class="destroy"
          onClick={_ -> api.remove(todo)}
        ></button>
      </li>
    </if>
  );

}
