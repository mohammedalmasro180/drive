// ignore: file_names

import 'package:drive011221/theme/color.dart';
import 'package:drive011221/widget/ViewPaths.dart';
import 'package:drive011221/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  String name;

  HomeScreen({Key? key,required this.name}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Future getdata() async{

      Uri uri = Uri.parse("https://shahieen.tpowep.com/json"+name+"");
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(json.decode(response.body));
      } else {
        print(response.statusCode);
      }


     var jsonsDataString = response.body;
      var _data=json.decode(jsonsDataString);

      return _data;

    }
    return     Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: drawer(),
        appBar: AppBar(
          backgroundColor: primary,
          title: Text("الصفحة الشخصية"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20,right: 10),
                child:FutureBuilder(
                    future: getdata(),
                    builder:(BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return  Row(
                          children: [
                            Expanded(child:
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 255,
                                    height: 255,
                                    child:  Image.asset("assets/0.jpg"),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),


                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:RaisedButton(
                                      color:
                                      c2,
                                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                                      onPressed:() {
                                      },

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("صورة   شخصية",style: TextStyle(color:Colors.white),),
                                          Icon(Icons.picture_in_picture_alt_outlined,color: Colors.white,
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),


                            ),
                            Expanded(child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text("الاسم"),
                                    subtitle: Text(
                                      snapshot.data[0]['name']
                                      ,),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text("العنوان"),
                                    subtitle: Text(
                                      snapshot.data[0]['address']
                                      ,),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text("الاختصاص"),
                                    subtitle: Text(
                                        snapshot.data[0]['Specialization']
                                    ),
                                  ),
                                ),

                              ],
                            ))

                          ],

                        );

                      }
                      else
                        return CircularProgressIndicator();
                    }
                ),

              ),
            ),


            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Paths(),
            )),

          ],
        ),
      ),
    );
  }
}
