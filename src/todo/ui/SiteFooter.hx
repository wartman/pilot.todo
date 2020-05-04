package todo.ui;

import js.html.Event;
import pilot.Component;
import todo.state.TodoState;
import todo.state.TodoFilter;
import todo.state.Todo;

class SiteFooter extends Component {
  
  @:attribute(consume) var state:TodoState;
  @:attribute var todos:Array<Todo>;
  @:attribute var filter:TodoFilter;

  override function render() return html(<>
    @if (todos.length > 0) <footer class={css('
        
      padding: 10px 15px;
      height: 20px;
      text-align: center;
      font-size: 15px;
      border-top: 1px solid #e6e6e6;

      &:before {
        content: "";
        position: absolute;
        right: 0;
        bottom: 0;
        left: 0;
        height: 50px;
        overflow: hidden;
        box-shadow: 0 1px 1px rgba(0, 0, 0, 0.2),
                    0 8px 0 -3px #f6f6f6,
                    0 9px 1px -3px rgba(0, 0, 0, 0.2),
                    0 16px 0 -6px #f6f6f6,
                    0 17px 2px -6px rgba(0, 0, 0, 0.2);
      }

      @media (max-width: 430px) {
        height: 50px;
      }

    ')}>
      <span class={css('
        float: left;
        text-align: left;
      ')}>{remaining()}</span>
      <ul class={css('

        margin: 0;
        padding: 0;
        list-style: none;
        position: absolute;
        right: 0;
        left: 0;
        
        @media (max-width: 430px) {
          bottom: 10px;
        }

        li {
          display: inline;
          a {
            color: inherit;
            margin: 3px;
            padding: 3px 7px;
            text-decoration: none;
            border: 1px solid transparent;
            border-radius: 3px;
            &:hover {
              border-color: rgba(175, 47, 47, 0.1);
            }
            &.selected {
              border-color: rgba(175, 47, 47, 0.2);
            }
          }
        }

      ')}>
        <li>
          <a 
            href="#all"
            class={getSelected(FilterAll)}
            onClick={e -> setFilter(e, FilterAll)}
          >All</a>
        </li>
        <li>
          <a 
            href="#pending"
            class={getSelected(FilterPending)}
            onClick={e -> setFilter(e, FilterPending)}
          >Pending</a>
        </li>
        <li>
          <a 
            href="#completed"
            class={getSelected(FilterCompleted)}
            onClick={e -> setFilter(e, FilterCompleted)}
          >Completed</a>
        </li>
      </ul>
      <button 
        class={css('
          float: right;
          position: relative;
          line-height: 20px;
          text-decoration: none;
          cursor: pointer;
        ')}
        onClick={ _ -> state.clearCompleted() }
      >Clear completed</button>
    </footer>
  </>);

  
  function remaining() {
    return switch state.remainingTodos {
      case 0: 'No items left';
      case 1: '1 item left';
      case remaining: '${remaining} items left';
    }
  }

  function getSelected(filter:TodoFilter) {
    return this.filter == filter ? 'selected' : null;
  }

  function setFilter(e:Event, filter:TodoFilter) {
    e.preventDefault();
    state.setFilter(filter);
  }

}
