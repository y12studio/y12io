// Copyright (c) 2014, y12studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache license.
import 'package:redstone/server.dart' as app;

@app.Route("/hello")
helloWorld() => "Hello, World!" + new DateTime.now().toIso8601String();

main() {
  app.setupConsoleLog();
  //app.start();
  // dokku default port is 5000
  app.start(port: 5000, staticDir: "../build/web", indexFiles: ["helloredstone.html"]);
}