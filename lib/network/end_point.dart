class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://localhost:8090";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  static const FINO_API = 'http://localhost:8090';
  // static const FINO_API = 'https://api.finoc.io';
  // static const FINO_SOCKET = 'http://localhost:3000';
  // static const FINO_SOCKET = 'https://stream.finoc.io';
  static const FINO_SOCKET = 'http://127.0.0.1:3000';
}
