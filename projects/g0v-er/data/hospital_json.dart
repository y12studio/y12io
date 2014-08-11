// Copyright (c) 2014, the Y12 Studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache-style license that can be found in the LICENSE file.
//------------------------
// pubspec.yaml
//   http: any
//
// output hospital.json
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  final String urlId = "https://raw.githubusercontent.com/y12studio/y12io/master/projects/g0v-er/data/hp_id.json";
  final String urlGeo = "https://raw.githubusercontent.com/y12studio/y12io/master/projects/g0v-er/data/hp_geo.json";
  final Map mapTarget ={'name':1, 'sn':2,'abbr':3};
  http.read(urlId).then((body) {
    Map mapId = JSON.decode(body);
    //print(mapId);
    http.read(urlGeo).then((bodyGeo) {
      List listGeo = JSON.decode(bodyGeo);
      mapId.forEach((k,v){
        var found = listGeo.firstWhere((item)=>item['name']==v['name'], orElse:()=>null);
        if(found!=null){
          v['lon']=found['lon'];
          v['lat']=found['lat'];
          v['addr']=found['addr'];
        }
      });
      print(JSON.encode(mapId));
    });
  });
}
