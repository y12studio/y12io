// Copyright (c) 2014, y12studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache license.
import 'package:bloodless/server.dart' as app;

@app.Route("/hello")
helloWorld() => "Hello, World!";

@app.Route("/user/:username")
helloUser(String username) => "hello $username";

main() {
  app.setupConsoleLog();
  // mapping to build directory.
  app.start(port:8080,staticDir:"../build/web",indexFiles:["app.html"]);
}
