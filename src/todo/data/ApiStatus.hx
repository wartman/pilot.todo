package todo.data;

enum ApiStatus {
  Ready;
  Loading;
  Failed(reason:String);
}
