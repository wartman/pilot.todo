package todo.data;

#if nodejs
  using haxe.Json;
  using haxe.io.Path;
  using sys.FileSystem;
  using sys.io.File;
#end

class Res {

  public static final DATA_NAME:String = haxe.macro.Compiler.getDefine('todo-data-name');

  #if (js && !nodejs)
    static final data = {
      var raw = Reflect.field(js.Browser.window, DATA_NAME);
      Reflect.deleteField(js.Browser.window, DATA_NAME);
      js.Browser.document.getElementById(DATA_NAME).remove();
      raw;
    };
  #else
    static final path:String = 'res/data.json';
    static final data = {
      var fullPath = Path.join([ Sys.getCwd(), path ]);
      if (!fullPath.exists()) {
        save(new Store({ todos: [] }).toJson());
      }
      File.getContent(fullPath).parse();
    };
  #end

  public static function get():Dynamic {
    return data;
  }

  #if nodejs

    public static function save(data:Dynamic) {
      var fullPath = Path.join([ Sys.getCwd(), path ]);
      if (!fullPath.directory().exists()) {
        fullPath.directory().createDirectory();
      }
      File.saveContent(fullPath, data.stringify());
    }

  #end

}
