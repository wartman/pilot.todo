package todo.module;

import capsule.*;
import todo.data.*;

class DataModule implements ServiceProvider {
  
  public function new() {}

  public function register(container:Container) {
    container.map(Store).toFactory(function () {
      return Store.fromJson(Res.get());
    }).asShared();
  }

}
