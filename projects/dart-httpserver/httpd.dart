import 'dart:io';

main() {
  HttpServer.bind('0.0.0.0', 8080).then((server) {
    server.listen((HttpRequest request) {
      DateTime now = new DateTime.now();
      request.response.write('Hello, world ${now.toIso8601String()}');
      request.response.close();
    });
  });
}
