import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking/homePage.dart';

import 'funtion.dart';

import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: course(),
    );
  }
}
class course extends StatefulWidget {
  @override

  _loginDemoState createState() => _loginDemoState();
}

class _loginDemoState extends State<course> {

  Future <dynamic> createData () async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url="";
    final ipaddress = prefs.getString('ip') ?? '';
    final lid = prefs.getString('lid') ?? '';



    url = 'http://' + ipaddress + ':5000/view_booking?id='+lid;

    var response = await http.get(Uri.parse(url));
    print("__________dxdddddddddddddddddddddddddddd__________________"+response.toString());

    print(response.body);

    // var jsonData=jsonDecode(response.body);
    //
    // print(jsonData);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print("+++++++++++++++++++++++++++++++++++++");
    return response.body;
  }


  @override
  Widget build(BuildContext context) {

    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),

              ),
              color: Color(0xff935e36),
            ),child: Stack(
            children: [
              Positioned(top:80,left:0,
              child:Container(
                height: 60,width: 200,
                decoration:BoxDecoration(
                  color:Colors.white,
                   borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                )
                  )
              )
              ),
              Positioned(
                  top: 110,
                  left: 20,

                  child:Text("BOOKING HISTORY",style:TextStyle(fontSize:20,color:Color(0xFF363f93)),))
              
            ],
          ),
          ),
        // Expanded(child:ListView(
        //   children: [
        //
        //     Container(
        //       margin: const EdgeInsets.only(
        //         bottom: 10,top: 25),
        //   height: 200,
        //   padding:
        //   const EdgeInsets.only(
        //     left: 20,right: 20,bottom: 20),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Color(0xFf363f93),
        //       borderRadius: const BorderRadius.only(
        //         bottomLeft: Radius.circular(80.0),
        //       ),
        //       boxShadow: [
        //         new BoxShadow(
        //           color: Color(0xFF363f93).withOpacity(0.3),
        //           offset: new Offset(-10.0, 0.0),
        //           blurRadius: 20.0,
        //           spreadRadius: 4.0
        //         ),
        //       ]
        //     ),
        //     padding: const EdgeInsets.only(
        //       left: 32,
        //       top: 50.0,
        //       bottom: 50,
        //     ),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children:<Widget> [
        //         Text("eee",style: TextStyle(color: Colors.white,
        //         fontSize: 12),
        //         ),
        //
        //       ],
        //     ),
        //       ),
        //     )
        //   ],
        // ))

          Expanded(child: FutureBuilder(

            future:  createData(),
            builder: (context,snapshot){
              print("=================+");
              print(snapshot.data.toString());
              var lis=snapshot.data;
              var jsonData=jsonDecode(lis.toString().replaceAll("'", '"'));
              print(jsonData);
              print(jsonData.length);

              if (snapshot.data==null)
              {

                return Container(child: Center(child: Text('No route'),),
                );
              }
              // return Container(child: Center(child: Text('Sampleeeee'),),
              // );
              else
                return ListView.builder(itemCount: jsonData.length,itemBuilder: (context,i)
                {
                  return ListTile(
                    title:                  Row(



                      children: [

                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 10,top: 25),

                          width: 320,
                          padding:
                          const EdgeInsets.only(
                              left: 10,right: 10,bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff935e36),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(50.0),
                                ),
                                boxShadow: [
                                  new BoxShadow(
                                      color: Color(0xff212124).withOpacity(0.3),
                                      offset: new Offset(-10.0, 0.0),
                                      blurRadius: 05.0,
                                      spreadRadius: 8.0
                                  ),
                                ]
                            ),
                            padding: const EdgeInsets.only(
                              left: 32,
                              top: 50.0,
                              bottom: 28,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:<Widget> [
                                Text(jsonData[i]['t_name']+" "+jsonData[i]['description']+"\n"+jsonData[i]['date']+" "+jsonData[i]['slot']+"\n"+jsonData[i]['status'],style: TextStyle(color: Colors.white,
                                    fontSize: 15),
                                ),
                                if(jsonData[i]['d']>0)
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                        color: Colors.black,
                                        onPressed: ()async {




                                            SharedPreferences prefs = await SharedPreferences.getInstance();


                                            final ipaddress = prefs.getString('ip') ?? '';

                                            final bid = jsonData[i]['b_id'].toString();


                                            var  url ='http://' + ipaddress + ':5000/deletebooking?bid='+bid;

                                            print(url);

                                            var   data = await fetchdata(url);
                                            print("================================================================");
                                            print(url);
                                            //
                                            var decoded = jsonDecode(data.replaceAll("'", "\""));
                                            print(decoded);
                                            print("+++++++++++++++++++++");
                                            // setState(() async {
                                            var  output = decoded['res'].toString();



                                            print(
                                                "*****************************************************************"+output);
                                            if(output=="true")
                                            {
                                              _showToast(context, "Deleted");
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (_) =>  HomePage()));
                                            }
                                            else{_showToast(context, output);}















                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                        )),
                                  )


                              ],
                            ),
                          ),
                        )
                      ],
                    ),


                    // trailing: Text(jsonData[i]['country'] ),
                  );
                });
            },

          ),),

        ],
      ),

    );





    // TODO: implement build
    throw UnimplementedError();
  }
}
void _showToast(BuildContext context,String cnt) {
  final scaffold = ScaffoldMessenger.of(context);
  String mycnt = cnt;
  scaffold.showSnackBar(
    SnackBar(
      content: Text(mycnt.toString()),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );}
