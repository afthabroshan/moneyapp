class UserSession {
  static final UserSession _instance = UserSession._internal();

  factory UserSession() => _instance;

  UserSession._internal();

  int? userId;

  void setUserId(int id) {
    userId = id;
  }

  int? getUserId() {
    return userId;
  }
}
