import 'package:redstone/server.dart' as app;
import 'package:shelf_static/shelf_static.dart';

@app.Route("/hello")
helloWorld() => "Hello, World!";

@app.Interceptor(r'/.*')
interceptor() {
  app.chain.next(() {
    app.response = app.response.change(headers: {
      "Access-Control-Allow-Origin": "*"
    });
  });
}

main() {
  app.setupConsoleLog();
  app.setShelfHandler(createStaticHandler("../build/web", 
                                           defaultDocument: "foopolymer.html", 
                                           serveFilesOutsidePath: true));
  app.start();
}