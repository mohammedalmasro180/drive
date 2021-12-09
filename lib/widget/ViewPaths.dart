
import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
class Paths extends StatelessWidget {
  const Paths({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future getdata() async{

      Uri uri =     Uri.parse("https://tpowep.com/pro/api/api.php");
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(json.decode(response.body));
      } else {
        print(response.statusCode);

      }


      String jsonsDataString = response.body.toString();
      var    _data = jsonDecode(jsonsDataString);
      print(_data.toString());


      return _data;

    }
    return  Scaffold(


        body: FutureBuilder(
            future: getdata(),
            builder:(BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(

                    itemCount: snapshot.data.length,

                    itemBuilder: (context,i) {
                      return ListTile(
                       subtitle:  Text(snapshot.data[i]['timer'].toString(),),
                        title:  Row(
                          children: [
                            Expanded(child: Text(snapshot.data[i]['form'].toString(),style: TextStyle(fontSize: 15,),)),

                            Expanded(child: Icon(Icons.arrow_forward,size: 25,)),
                            Expanded(child: Text(
                              snapshot.data[i]['too'].toString(),
                              style: TextStyle(fontSize: 15,),)),
                            Expanded(child:RaisedButton(
                              color: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                              onPressed:() {
                              },

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("حجز",style: TextStyle(color:Colors.white),),

                                ],
                              ),
                            )),


                          ],
                        ),
                      );

                    }
                );

              }
              else
                return CircularProgressIndicator();
            }
        )

    );
  }
}
