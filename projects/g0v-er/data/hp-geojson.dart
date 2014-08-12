// Copyright (c) 2014, the Y12 Studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache-style license that can be found in the LICENSE file.
//------------------------
// pubspec.yaml
//   http: any
//
// output hospital.json
import 'dart:convert';
import 'dart:io';
import 'dart:async';

String getPrettyJSONString(jsonObject) {
  var encoder = new JsonEncoder.withIndent("     ");
  return encoder.convert(jsonObject);
}
/**
geometry: {
 type: "Point",
 coordinates: [40.728926,34.749855]
}
*/
void main() {

  Future<String> finishedReading = new File("hp-geo-raw1.json").readAsString(encoding: UTF8).then((text) {
    Map rMap = JSON.decode(text);
    rMap['hospitals'].forEach((k, v) {
      if (v.runtimeType.toString().contains('Map')) {
        Map m = v;
        if (m.containsKey('lon')) {
          Map geometry = new Map();
          List coordinates = [double.parse(m['lon']), double.parse(m['lat'])];
          m['geometry'] = geometry;
          geometry['coordinates'] = coordinates;
          geometry['type'] = 'Point';
          m.remove('lon');
          m.remove('lat');
        }
      }
    });
    String rj = getPrettyJSONString(rMap);
    print(rj);
    new File("hp.geojson").writeAsString(rj,encoding: UTF8);
  });
}
