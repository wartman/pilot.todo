package todo.module;

import capsule.Module;
import todo.data.*;

class DataModule implements Module {

#if nodejs

  @:provide
  @:share
  public function _():Store {
    // todo: load from file
    return new Store({
      todos: [] 
    });
  }

#else
  
  @:provide
  @:share
  public function _():Store {
    return Store.fromJson(Loader.get());
  }

#end

}
