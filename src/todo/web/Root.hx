package todo.web;

import tink.http.Response;

using tink.CoreApi;

interface Root {

  @:get('/')
  public function index():OutgoingResponse;

  @:post('todo')
  public function addTodo(body:{ content:String }):Promise<{ data: { 
    id:Int,
    content:String, 
    complete:Bool 
  } }>;

  @:put('todo/$id')
  public function updateTodo(id:Int, body:{ 
    content:String,
    complete:Bool 
  }):Promise<{ data: { 
    id:Int, 
    content:String, 
    complete:Bool 
  } }>;

  @:delete('todo/$id')
  public function removeTodo(id:Int):Promise<{ data: { id:Int } }>;

}
