
import 'dart:convert';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking/funtion.dart';
import 'package:turf_booking/homePage.dart';

import 'my_match_more.dart';
import 'package:url_launcher/url_launcher.dart';
void main()
{
  runApp(history());
}
class history extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: historyhome(),
    );
  }
}
class historyhome extends StatefulWidget
{
  @override
  _DataFromAPIState createState() =>_DataFromAPIState();

}
List<String> res=[];
class _DataFromAPIState extends State<historyhome> {
  final fid="",tid="";

  TextEditingController tController = new TextEditingController();
  TextEditingController pController = new TextEditingController();

  Future <dynamic> createData () async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    final fid = prefs.getString('lid') ?? '';
    final t = prefs.getString('t') ?? '';
    final p = prefs.getString('p') ?? '';
    print("fffffffffffffffffffffffff");
    print(fid);

    tController.text=t;
    pController.text=p;


    var url="";



    final ipaddress = prefs.getString('ip') ?? '';
    final lid = prefs.getString('lid') ?? '';

    url = 'http://' + ipaddress + ':5000/history?lid='+lid;
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return response.body;

  }
  @override
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blueGrey,
      body:Form(
          key: _formKey,

          child: Center(

            child: new Column(

              mainAxisSize: MainAxisSize.max,


              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>
              [







                Expanded(child: FutureBuilder(

                  future:  createData(),
                  builder: (context,snapshot){
                    print("=================+");
                    print(snapshot.data.toString()+"=====================>");

                    var lis=snapshot.data;
                    var jsonData=jsonDecode(lis.toString().replaceAll("'", '"'));
                    print(jsonData);
                    print(jsonData.length);

                    if (jsonData.length==0 )
                    {

                      return Container(child: Center(child: Text('No data'),),
                      );
                    }
                    // return Container(child: Center(child: Text('Sampleeeee'),),
                    // );
                    else

                      return ListView.builder(itemCount: jsonData.length,
                          itemBuilder: (context,i)

                          {

                            return ListTile(

                              title: Row(

                                children: [



                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 0,top: 15),

                                    width: 320,
                                    padding:
                                    const EdgeInsets.only(
                                        left: 25,right: 20,bottom: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xfff3f8f8),
                                          borderRadius:
                                          BorderRadius.only(
                                            bottomLeft: Radius.circular(55.0),
                                            topLeft: Radius.circular(55.0),
                                            bottomRight: Radius.circular(55.0),
                                            topRight: Radius.circular(55.0),

                                          ),

                                          boxShadow: [
                                            new BoxShadow(
                                                color: Color(0xFF363f93).withOpacity(0.3),
                                                offset: new Offset(-10.0, 0.0),
                                                blurRadius: 20.0,
                                                spreadRadius: 4.0
                                            ),
                                          ]
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 0,
                                        top: 10.0,


                                      ),
                                      child: Column(

                                        children:<Widget> [

                                          Text(jsonData[i]['t_name']+" "+jsonData[i]['date'],style: TextStyle(color: Colors.black,
                                              fontSize: 15),
                                          ),
                                          Text(jsonData[i]['position']+" "+jsonData[i]['slot'],style: TextStyle(color: Colors.black,
                                              fontSize: 15),
                                          ),




                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [ CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Color(0xff4c505b),
                                        child: IconButton(
                                            color: Colors.black,
                                            onPressed: ()async {

                                              SharedPreferences prefs = await SharedPreferences.getInstance();


                                              prefs.setString("bid",(jsonData[i]['b_id']).toString());
                                              // prefs.setString("rate",(jsonData[i]['rate']).toString());
                                              // prefs.setString("d","");






                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (_) =>  mymatch_more()));








                                            },
                                            icon: Icon(
                                              Icons.arrow_forward,
                                            )),
                                      ),
                                          if(jsonData[i]['s']=="1")
                                            SizedBox(width: 10),
                                          if(jsonData[i]['s']=="0")
                                          SizedBox(width: 36),
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Color(0xff4c505b),
                                            child: IconButton(
                                                color: Colors.black,
                                                onPressed: ()async {



                                                  String url="http://maps.google.com?q="+(jsonData[i]['latitude']).toString()+","+(jsonData[i]['longitude']).toString();

                                                  // final chromeURL = 'googlechrome://$url';

                                                  // if (await canLaunch(url)) {
                                                    await launch(url);
                                                  // } else {
                                                  //   throw 'Could not launch $chromeURL';
                                                  // }






                                                },
                                                icon: Icon(
                                                  Icons.place,
                                                )),
                                          ),

                                         if(jsonData[i]['s']=="1")
                                          SizedBox(width: 10),
                                          if(jsonData[i]['s']=="1")
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Color(0xff4c505b),
                                            child: IconButton(
                                                color: Colors.black,
                                                onPressed: ()async {






                                                  SharedPreferences prefs = await SharedPreferences.getInstance();


                                                  final ipaddress = prefs.getString('ip') ?? '';

                                                  final bid = jsonData[i]['b_id'].toString();

                                                  final lid = prefs.getString('lid') ?? '';
                                                  var  url ='http://' + ipaddress + ':5000/deletetbooking?bid='+bid+"&uid="+lid;

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

                                      )

                                         ,




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






          )
      ),


    );


  }
}




class User{
  final  String name,passd;
  User(this.name,this.passd);
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