
import 'dart:convert';
import 'dart:ui';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_match2.dart';
import 'select_sloat.dart';
import 'package:location/location.dart';

void main()
{
  runApp(addmatch());
}
class addmatch extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: addmatch_home(),
    );
  }
}
class addmatch_home extends StatefulWidget
{
  @override
  _DataFromAPIStatee createState() =>_DataFromAPIStatee();

}
List<String> res=[];
class _DataFromAPIStatee extends State<addmatch_home> {
  final fid="",tid="";

  TextEditingController tController = new TextEditingController();
  TextEditingController pController = new TextEditingController();
  String _latitude = '';
  String _longitude = '';
  String ip="";
  void getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print('Location service is disabled');
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print('Location permission is denied');
        return;
      }
    }

    locationData = await location.getLocation();
    setState(() {
      _latitude = locationData.latitude.toString();
      _longitude = locationData.longitude.toString();
    });
  }


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

    if(_latitude=="") {
      getCurrentLocation();
    }

    final ipaddress = prefs.getString('ip') ?? '';
    ip=ipaddress;

    url = 'http://' + ipaddress + ':5000/search_turf?p='+p+"&t="+t+"&lati="+_latitude+"&lon="+_longitude;
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
                Container(

                  padding: EdgeInsets.only(left: 12,top: 40,right: 22),


                  child: TextFormField(

                    controller: tController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Type to search';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelText: 'Type',
                      hintText: 'Enter your Type to search',

                    ),


                  ),

                ),
                Container(

                  padding: EdgeInsets.only(left: 12,top: 10,right: 22),


                  child: TextFormField(

                    controller: pController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Place to search';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelText: 'Place',
                      hintText: 'Enter your Place to search',

                    ),


                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                          color: Colors.black,
                          onPressed: ()async {
                            var t=tController.text.toString();
                            var p=pController.text.toString();

                            print(_formKey.currentState!.validate());

                            if (!_formKey.currentState!.validate()) {
                              print("vvvvvvvvvvvvvvvvvvvvvvvvvvvv");
                            }
                            else {
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              prefs.setString("t",t);
                              prefs.setString("p", p);
                              final ipaddress = prefs.getString('ip') ?? '';
                              final ffid = prefs.getString('lid') ?? '';





                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) =>  addmatch_home()));





                            }


                          },
                          icon: Icon(
                            Icons.arrow_forward,
                          )),
                    )
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
                                          Image.network("http://"+ip+":5000/static/timg/"+jsonData[i]['l_id'].toString()+".png",width: 200,
                                            height: 150,),

                                          Text(jsonData[i]['t_name']+":  "+jsonData[i]['description'],style: TextStyle(color: Colors.black,
                                              fontSize: 15),
                                          ),
                                          Text(jsonData[i]['rate'],style: TextStyle(color: Colors.black,
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


                                                  prefs.setString("tid",(jsonData[i]['rate_id']).toString());
                                                  prefs.setString("rate",(jsonData[i]['rate']).toString());
                                                  prefs.setString("description",(jsonData[i]['description']).toString());
                                                  prefs.setString("d","");






                                                  Navigator.push(
                                                      context, MaterialPageRoute(builder: (_) =>  add_match2_home()));








                                                },
                                                icon: Icon(
                                                  Icons.arrow_forward,
                                                )),
                                          ),
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
                          ])




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

