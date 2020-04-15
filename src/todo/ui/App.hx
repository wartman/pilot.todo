package todo.ui;

import pilot.Component;
import pilot.Cargo;
import todo.data.Store;

class App extends Component {

  @:attribute var store:Store;
  final rootStyle = css('

    html, body {
      margin: 0;
      padding: 0;
    }

    body {
      font: 14px "Helvetica Neue", Helvetica, Arial, sans-serif;
      line-height: 1.4em;
      background: ${Color.secondary};
      color: ${Color.primary};
      min-width: 230px;
      max-width: 550px;
      margin: 0 auto;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
      font-weight: 300;
    }

    :focus {
      outline: 0;
    }

  ', { global: true });

  override function render() return Cargo.observeHtml(
    <div id="App" class={rootStyle.add(css('
      
      background: #fff;
      margin: 130px auto 40px;
      position: relative;
      box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 25px 50px 0 rgba(0, 0, 0, 0.1);

      input {
        &::placeholder {
          font-style: italic;
          font-weight: 300;
          color: #e6e6e6;
        }
      }

      button {
        margin: 0;
        padding: 0;
        border: 0;
        background: none;
        font-size: 100%;
        vertical-align: baseline;
        font-family: inherit;
        font-weight: inherit;
        color: inherit;
        appearance: none;
        -webkit-appearance: none;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
      }

    '))}>
      <StoreProvider store={store}>
        @switch store.status {
          case Ready: null;
          case Loading: <Spinner />;
          case Failed(_): null;
        }
        <SiteHeader />
        <TodoList todos={store.visibleTodos} />
        <SiteFooter todos={store.todos} filter={store.filter} />
      </StoreProvider>
    </div>
  );

}
