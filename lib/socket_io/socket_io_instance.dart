class SocketIOInstance {
  static final SocketIOInstance _singleton = SocketIOInstance._internal();

  factory SocketIOInstance() {
    return _singleton;
  }

  SocketIOInstance._internal();
}
