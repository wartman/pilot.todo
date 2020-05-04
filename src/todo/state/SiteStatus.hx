package todo.state;

enum SiteStatus {
  Ready;
  Loading;
  Failed(reason:String);
}
