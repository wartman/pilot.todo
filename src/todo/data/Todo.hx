package todo.data;

import pilot.cargo.Model;

class Todo implements Model {

  static var ids:Int = 0;

  @:prop final id:Int = ids++;
  @:prop(mutable = true) var content:String;
  @:prop(mutable = true) var complete:Bool = false;

}
