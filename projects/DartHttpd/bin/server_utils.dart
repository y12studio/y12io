// Copyright (c) 2014, y12studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache license.
library server_utils;

import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'packages/route/server.dart';
import 'dart:io';

final MY_HTTP_ROOT_PATH = Platform.script.resolve('../build/web').toFilePath();

class ReRouterVirDir {
  Router router;
  VirtualDirectory virDir;
  ReRouterVirDir(this.router, this.virDir);
}

ReRouterVirDir initRouterVirDir(HttpServer server,String welcomeFile){
  
  final virDir = new VirtualDirectory(MY_HTTP_ROOT_PATH)
      ..jailRoot = false
      ..allowDirectoryListing = true;
  
  virDir.directoryHandler = (dir, req) {
    // Redirect directory requests to index.html files.
    var indexUri = new Uri.file(dir.path).resolve(welcomeFile);
    virDir.serveFile(new File(indexUri.toFilePath()), req);
  };
  
  final router = new Router(server);
  virDir.serve(router.defaultStream);
  return new ReRouterVirDir(router,virDir);
}