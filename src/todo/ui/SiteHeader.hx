package todo.ui;

import pilot.Component;
import todo.client.TodoApi;
import todo.data.*;

class SiteHeader extends Component {

  #if !nodejs
    @:attribute(inject = ApiProvider.ID) var api:TodoApi;
  #end

  override function render() return html(
    <header class="todo-header">
      <h1 class@style={
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
      }>todos</h1>
      <TodoInput
        inputClass="new-todo"
        value=""
        save={value -> {
          #if !nodejs
            api.add(new Todo({ content: value }));
          #end
        }}
      />
    </header>
  );

}

// abstract SiteHeader(VNode) to VNode {
  
//   public function new(props:{
//     store:Store
//   }) {
//     this = html(<header class="todo-header">
//       <h1 class@style={
//         position: absolute;
//         top: -155px;
//         width: 100%;
//         font-size: 100px;
//         font-weight: 100;
//         text-align: center;
//         color: rgba(175, 47, 47, 0.15);
//         -webkit-text-rendering: optimizeLegibility;
//         -moz-text-rendering: optimizeLegibility;
//         text-rendering: optimizeLegibility;
//       }>todos</h1>
//       <TodoInput
//         inputClass="new-todo"
//         value=""
//         save={value -> props.store.addTodo(new Todo({ content: value }))}
//       />
//     </header>);    
//   }

// }
