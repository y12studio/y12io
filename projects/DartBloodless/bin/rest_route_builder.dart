// Copyright (c) 2014, y12studio.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Apache license.
/*
 * build the default rest group route in bloodless
 */
String template = """
@app.Group("/user")
class UserService {
  @app.Route("/find")
  findUser(@app.QueryParam("n") String name,
           @app.QueryParam("c") String city) {
    return 'hello user';
  }

  @app.Route("/add", methods: const [app.POST])
  addUser(@app.Body(app.JSON) Map json) {
    return 'add json';
  }
}
""";

var model = {
    "name":"User",
    "fields":[
         ["name","String"],
         ["city","String"]
     ]
};

main(){
  
  String modelName = model['name'];
  
  String findParam = model['fields'].map((v)=>'@app.QueryParam("${v[0]}") ${v[1]} ${v[0]}').join(',');
  var sb = new StringBuffer()
  ..write('@app.Group("/${modelName.toLowerCase()}")\n')
  ..write('class ${modelName}Service {\n')
  ..write('// find \n')
  ..write('@app.Route("/find")\n')
  ..write('find${modelName}($findParam){\n //\n}\n')
  ..write('// add \n')
  ..write('@app.Route("/add", methods: const [app.POST])\n')
  ..write('add${modelName}(){\n //\n}\n')
  ..write('}\n');
  print(sb.toString());
}