package todo.state;

using tink.CoreApi;

interface TodoApi {
  public function addTodo(content:String):Promise<Todo>;
  public function updateTodo(id:Int, content:String, complete:Bool):Promise<Todo>;
  public function removeTodo(todo:Todo):Promise<Todo>;
  public function getTodos():Array<Todo>;
  // public function fetchTodos():Promise<Array<Todo>>;
}
