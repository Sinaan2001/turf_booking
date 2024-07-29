
import 'dart:convert';
import 'dart:ui';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking/funtion.dart';
import 'package:turf_booking/payment.dart';

import 'addmatch.dart';
import 'homePage.dart';
import 'select_sloat.dart';


void main()
{
  runApp(view_match1());
}
class view_match1 extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: view_match1home(),
    );
  }
}
class view_match1home extends StatefulWidget
{
  @override
  _DataFromAPIState createState() =>_DataFromAPIState();

}
List<String> res=[];
class _DataFromAPIState extends State<view_match1home> {
  final fid="",tid="";

  TextEditingController tController = new TextEditingController();
  TextEditingController pController = new TextEditingController();

  Future <dynamic> createData () async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    final bid = prefs.getString('bid') ?? '';
    final lid = prefs.getString('lid') ?? '';
    // final p = prefs.getString('p') ?? '';


    // tController.text=t;
    // pController.text=p;


    var url="";



    final ipaddress = prefs.getString('ip') ?? '';

    url = 'http://' + ipaddress + ':5000/view_match1?lid='+lid+"&bid="+bid;
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(

                      padding: EdgeInsets.only(left: 12,top: 40,right: 22),


                      child: Text(""),

                    ),

                  ],
                ),






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


                                  if(jsonData[i]['t']=="t1")
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 0,top: 15),

                                    width: 320,
                                    padding:
                                    const EdgeInsets.only(
                                        left: 25,right: 20,bottom: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff00bbff),
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
                                          if(jsonData[i]['name']=="Pending")
                                            Text(jsonData[i]['position']+"\n"+jsonData[i]['name'],style: TextStyle(color: Colors.white,
                                                fontSize: 15),
                                            ),
                                          // if(jsonData[i]['name']=="Pending")
                                          //   Text("amount",style: TextStyle(color: Colors.white,
                                          //       fontSize: 15),
                                          //   ),
                                          if(jsonData[i]['name']!="Pending")
                                            Text(jsonData[i]['position']+"\n"+jsonData[i]['name'],style: TextStyle(color: Colors.red,
                                                fontSize: 15),
                                            ),
                                          if(jsonData[i]['name']=="Pending")

                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Color(0xff4c505b),
                                              child: IconButton(
                                                  color: Colors.black,
                                                  onPressed: ()
                                                  async {






                                                    SharedPreferences prefs = await SharedPreferences.getInstance();


                                                    final ipaddress = prefs.getString('ip') ?? '';
                                                    final ffid = prefs.getString('lid') ?? '';

                                                    final bid = prefs.getString('bid') ?? '';



                                                    var  url ='http://' + ipaddress + ':5000/book_match?lid=' + ffid+"&tid="+jsonData[i]['tid'].toString()+"&p="+jsonData[i]['position'];

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
                                                      _showToast(context, "Booking completed");
                                                      Navigator.push(
                                                          context, MaterialPageRoute(builder: (_) =>  HomePage()));
                                                    }
                                                    else{_showToast(context, output);}









                                                  },
                                                  icon: Icon(
                                                    Icons.bookmark_add,
                                                  )),
                                            )











                                        ],
                                      ),
                                    ),


                                  ),


                                  if(jsonData[i]['t']=="t2")
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 0,top: 15),

                                    width: 320,
                                    padding:
                                    const EdgeInsets.only(
                                        left: 25,right: 20,bottom: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xffffff00),
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
                                          if(jsonData[i]['name']=="Pending")
                                            Text(jsonData[i]['position']+"\n"+jsonData[i]['name'],style: TextStyle(color: Colors.black,
                                                fontSize: 15),
                                            ),if(jsonData[i]['name']!="Pending")
                                            Text(jsonData[i]['position']+"\n"+jsonData[i]['name'],style: TextStyle(color: Colors.red,
                                                fontSize: 15),
                                            ),
                                          if(jsonData[i]['name']=="Pending")

                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Color(0xff4c505b),
                                              child: IconButton(
                                                  color: Colors.black,
                                                  onPressed: ()
                                                  async {






                                                    SharedPreferences prefs = await SharedPreferences.getInstance();


                                                    final ipaddress = prefs.getString('ip') ?? '';
                                                    final ffid = prefs.getString('lid') ?? '';

                                                    final bid = prefs.getString('bid') ?? '';



                                                    var  url ='http://' + ipaddress + ':5000/book_match?lid=' + ffid+"&tid="+jsonData[i]['tid'].toString()+"&p="+jsonData[i]['position'];

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
                                                      _showToast(context, "Booking completed");
                                                      Navigator.push(
                                                          context, MaterialPageRoute(builder: (_) =>  HomePage()));
                                                    }
                                                    else{_showToast(context, output);}









                                                  },
                                                  icon: Icon(
                                                    Icons.bookmark_add,
                                                  )),
                                            )











                                        ],
                                      ),
                                    ),


                                  ),




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
