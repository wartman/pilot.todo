package todo.data;

import pilot.cargo.Model;

class Todo implements Model {

  static var ids:Int = 0;

  @:prop final id:Int = ids++;
  @:prop(mutable) var content:String;
  @:prop(mutable) var complete:Bool = false;
  @:prop(mutable) var syncing:Bool = false;

}
