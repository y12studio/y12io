library simple_http_server;

import 'dart:io';
import 'package:http_server/http_server.dart' show VirtualDirectory;

void main() {
  final MY_HTTP_ROOT_PATH = Platform.script.resolve('../build/web').toFilePath();
  print(MY_HTTP_ROOT_PATH);
  final virDir = new VirtualDirectory(MY_HTTP_ROOT_PATH)
    ..allowDirectoryListing = true;

  HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080).then((server) {
    server.listen((request) {
      virDir.serveRequest(request);
    });
  });
}