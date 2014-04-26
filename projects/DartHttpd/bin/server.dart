// Copyright (c) 2014, y12studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache license.
library simple_http_server;

import 'dart:io';
import 'server_utils.dart';

void main() {
  // print(InternetAddress.ANY_IP_V4);
  // print(InternetAddress.LOOPBACK_IP_V4);
  HttpServer.bind(InternetAddress.ANY_IP_V4, 8080).then((server) {
    initRouterVirDir(server,'darthttpd.html');
  });
}
