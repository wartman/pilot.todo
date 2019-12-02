package todo.data;

class Loader {

  public static final DATA_NAME:String = haxe.macro.Compiler.getDefine('todo-data-name');

  #if (js && !nodejs)
    static final _data = {
      var raw = Reflect.field(js.Browser.window, DATA_NAME);
      Reflect.deleteField(js.Browser.window, DATA_NAME);
      js.Browser.document.getElementById(DATA_NAME).remove();
      raw;
    };
  #else
    static final _data = {};
  #end

  public static function get():Dynamic {
    return _data;
  }

}
