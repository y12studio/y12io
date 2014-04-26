// Copyright (c) 2014, y12studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache license.
import 'package:bloodless/server.dart' as app;
import 'dart:io';
import 'packages/crypto/crypto.dart';
import 'packages/utf/utf.dart';
import 'packages/logging/logging.dart';

final Logger _logger = new Logger("dartbloodless_server");

@app.Route("/hello")
helloWorld() => "Hello, World!";

@app.Interceptor(r'/adminsess/.*')
adminSessionFilter() {
  if (app.request.session["username"] != null) {
    app.chain.next();
  } else {
    app.chain.interrupt(statusCode: HttpStatus.UNAUTHORIZED);
    //or app.redirect("/login.html");
  }
}

@app.Interceptor(r'/.*')
handleResponseHeader() {
  app.request.response.headers.add("Access-Control-Allow-Origin", "*");
  app.chain.next();
}

@app.Route("/adminbasic")
adminbasic() => "Hello, World admin basic!";

@app.Interceptor('/adminbasic')
adminBasicAuthFilter() {
  
  String user="user";
  String pass="pass";
  
  bool r = false;
  if (app.request.headers[HttpHeaders.AUTHORIZATION] != null) {
    String authorization = app.request.headers[HttpHeaders.AUTHORIZATION][0];
    List<String> tokens = authorization.split(" ");
    String auth = CryptoUtils.bytesToBase64(encodeUtf8("$user:$pass"));
    if ("Basic" == tokens[0] && auth == tokens[1]) {
      r = true;
    }
  }
  
  if (r) {
    app.chain.next();
  } else {
    app.request.response.headers.set(HttpHeaders.WWW_AUTHENTICATE, "Basic realm=\"DartBloodless\"");
    app.chain.interrupt(statusCode: HttpStatus.UNAUTHORIZED);
    //or app.redirect("/login.html");
  }
}

@app.Route("/user/:username")
helloUser(String username) => "hello $username";

main() {
  app.setupConsoleLog();
  // mapping to build directory.
  app.start(port: 8080, staticDir: "../build/web", indexFiles: ["app.html"]);
}
