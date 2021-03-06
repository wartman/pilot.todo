package todo.ui;

import js.html.Element;
import pilot.Component;

class TodoInput extends Component {
  
  @:attribute var inputClass:String = 'edit';
  @:attribute var placeholder:String = 'What needs doing?';
  @:attribute var value:String;
  @:attribute var save:(value:String)->Void;
  @:attribute var requestClose:()->Void = null;
  var ref:Element;

  override function render() {
    return html(
      <div class={css('
        
        input {
          position: relative;
          margin: 0;
          width: 100%;
          font-size: 24px;
          font-family: inherit;
          font-weight: inherit;
          line-height: 1.4em;
          color: inherit;
          padding: 6px;
          border: 1px solid #999;
          box-shadow: inset 0 -1px 5px 0 rgba(0, 0, 0, 0.2);
          box-sizing: border-box;
          -webkit-font-smoothing: antialiased;
          -moz-osx-font-smoothing: grayscale;
        }

        .new-todo {
          padding: 16px 16px 16px 60px;
          border: none;
          background: rgba(0, 0, 0, 0.003);
          box-shadow: inset 0 -2px 1px rgba(0,0,0,0.03);
        }

      ')}>
        <input
          @ref={node -> ref = cast node}
          class={inputClass}
          value={value}
          placeholder={placeholder}
          onClick={e -> e.stopPropagation()}
          onKeyDown={e -> {
            #if (js && !nodejs)
              var input:js.html.InputElement = cast e.target;
              var keyboardEvent:js.html.KeyboardEvent = cast e;
              if (keyboardEvent.key == 'Enter') {
                var value = input.value;
                input.value = '';
                input.blur();
                save(value);
              }
            #end
          }}
        />
      </div>
    );
  }

  #if (js && !nodejs)

    function clickOff(_) {
      js.Browser.window.removeEventListener('click', clickOff);
      requestClose();
    }

    @:effect(guard = requestClose != null)
    function setupListener() {
      ref.focus();
      js.Browser.window.addEventListener('click', clickOff);
    }
    
    @:dispose 
    function cleanup() {
      js.Browser.window.removeEventListener('click', clickOff);
    }

  #end

}
