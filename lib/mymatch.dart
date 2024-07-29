
import 'dart:convert';
import 'dart:ui';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking/funtion.dart';
import 'package:turf_booking/homePage.dart';

import 'addmatch.dart';
import 'my_match_more.dart';
import 'select_sloat.dart';


void main()
{
  runApp(mymatch());
}
class mymatch extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: mymatchhome(),
    );
  }
}
class mymatchhome extends StatefulWidget
{
  @override
  _DataFromAPIState createState() =>_DataFromAPIState();

}
List<String> res=[];
class _DataFromAPIState extends State<mymatchhome> {
  final fid="",tid="";

  TextEditingController tController = new TextEditingController();
  TextEditingController pController = new TextEditingController();

  Future <dynamic> createData () async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    final fid = prefs.getString('lid') ?? '';
    // final t = prefs.getString('t') ?? '';
    // final p = prefs.getString('p') ?? '';
    print("fffffffffffffffffffffffff");
    print(fid);

    // tController.text=t;
    // pController.text=p;


    var url="";



    final ipaddress = prefs.getString('ip') ?? '';

    url = 'http://' + ipaddress + ':5000/mymatch?lid='+fid;
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
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xff4c505b),
                  child: IconButton(
                      color: Colors.black,
                      onPressed: ()async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        prefs.setString("t","");
                        prefs.setString("p", "");
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) =>  addmatch_home()));

                      },
                      icon: Icon(
                        Icons.add,
                      )),
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

                                          Text(jsonData[i]['t_name']+":  "+jsonData[i]['slot'],style: TextStyle(color: Colors.black,
                                              fontSize: 15),
                                          ),
                                          Text(jsonData[i]['date'],style: TextStyle(color: Colors.black,
                                              fontSize: 15),
                                          ),




                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Color(0xff4c505b),
                                          child: IconButton(
                                              color: Colors.black,
                                              onPressed: ()async {

                                                SharedPreferences prefs = await SharedPreferences.getInstance();


                                                prefs.setString("bid",(jsonData[i]['b_id']).toString());







                                                Navigator.push(
                                                    context, MaterialPageRoute(builder: (_) =>  mymatch_more()));








                                              },
                                              icon: Icon(
                                                Icons.arrow_forward,
                                              )),
                                        ),
                                          SizedBox(width: 36),
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


                                      ],)






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