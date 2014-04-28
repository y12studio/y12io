// Copyright (c) 2014, y12studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache license.
import 'package:bloodless/server.dart' as app;
import 'dart:io';
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
  if(app.authenticateBasic(user, pass,realm:"Haha",abortOnFail: true)){
    app.chain.next();
  }
}



@app.Route("/userx/:username")
helloUser(String username) => "hello $username";

@app.Group("/user")
class UserService {
  @app.Route("/find")
  x(@app.QueryParam("n") String name,
           @app.QueryParam("c") String city) {
    return 'hello user $name';
  }

  @app.Route("/add", methods: const [app.POST])
  y(@app.Body(app.JSON) Map json) {
    return 'add json';
  }
}

main() {
  app.setupConsoleLog();
  // mapping to build directory.
  app.start(port: 8080, staticDir: "../build/web", indexFiles: ["app.html"]);
}
