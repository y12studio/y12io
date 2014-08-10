// Copyright (c) 2014, the Y12 Studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache-style license that can be found in the LICENSE file.
//------------------------
// pubspec.yaml
//   csv_utils: any
//   http: any
// 
import 'package:http/http.dart' as http;
import '../packages/csv_utils/csv_utils.dart';
import 'dart:convert';

void main() {
  print("Hello, World!");
  String url = "https://gist.githubusercontent.com/mcdlee/a3a7d55767e6f26fec44/raw/gistfile1.txt";
  http.read(url).then((body) {
    List rlist = new CsvConverter.Excel().parse(body).where((line) => line.length > 5 && line[0].length > 0).map((line) {
      Map rmap = new Map();
      rmap["name"] = line[1];
      rmap["addr"] = line[3];
      rmap['lon'] = line[4];
      rmap['lat'] = line[5];
      return rmap;
    }).toList();

    print(JSON.encode(rlist));

  });

}
