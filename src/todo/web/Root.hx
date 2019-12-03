package todo.web;

import tink.http.Response;

interface Root {

  @:get('/')
  public function index():OutgoingResponse;

  @:post('todo')
  public function addTodo(body:{ content:String }):{ data:{id:Int} };

  @:put('todo/$id')
  public function updateTodo(id:Int, body:{ content:String }):{ data:{id:Int} };

  @:delete('todo/$id')
  public function removeTodo(id:Int):{ data:{id:Int} };

}
