package todo.module;

import capsule.Module;
import todo.data.*;

class DataModule implements Module {
  
  @:provide
  @:share
  public function _():Store {
    return Store.fromJson(Res.get());
  }

}
