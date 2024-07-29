
import 'dart:convert';

import 'dart:ui';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking/payment.dart';
import 'package:turf_booking/payment1.dart';


void main()
{
  runApp(add_match2());
}
class add_match2 extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: add_match2_home(),
    );
  }
}
class add_match2_home extends StatefulWidget
{
  @override
  _DataFromAPIState createState() =>_DataFromAPIState();

}
List<String> res=[];
class _DataFromAPIState extends State<add_match2_home> {
  final fid="",tid="";
  int status=0;

  TextEditingController dController = new TextEditingController();


  Future <dynamic> createData () async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    final tid = prefs.getString('tid') ?? '';
    final d = prefs.getString('d') ?? '';
    if(status==0) {
      dController.text = d;
    }

    var url="";



    final ipaddress = prefs.getString('ip') ?? '';

    url = 'http://' + ipaddress + ':5000/select_sloat?d='+d+"&t="+tid;
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return response.body;

  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:  DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        status=1;
        dController.text = picked.toString().split(" ")[0]; // You can format the picked date as per your requirement
      });
    }
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

                    controller: dController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter date';
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
                      labelText: 'Date',
                      hintText: 'Enter your date',

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
                            var d=dController.text.toString();


                            print(_formKey.currentState!.validate());

                            if (!_formKey.currentState!.validate()) {
                              print("vvvvvvvvvvvvvvvvvvvvvvvvvvvv");
                            }
                            else {
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              prefs.setString("d",d);
                              status=0;
                              final ipaddress = prefs.getString('ip') ?? '';
                              final ffid = prefs.getString('lid') ?? '';





                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) =>  add_match2_home()));





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
                    print(snapshot.data.toString()+"***************88888888888888");
                    if (snapshot.data.toString()=="")
                    {

                      return Container(child: Center(child: Text('Select date'),),
                      );
                    }
                    var lis=snapshot.data;
                    var jsonData=jsonDecode(lis.toString().replaceAll("'", '"'));
                    print(jsonData);
                    print(jsonData.length);

                    if (jsonData.length==0)
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
                                            if(jsonData[i]['s']=="0")

                                              new BoxShadow(
                                                  color: Color(0xFF363f93).withOpacity(0.3),
                                                  offset: new Offset(-10.0, 0.0),
                                                  blurRadius: 20.0,
                                                  spreadRadius: 4.0
                                              ),
                                            if(jsonData[i]['s']=="1")
                                              new BoxShadow(
                                                  color: Color(0xFF000000).withOpacity(0.3),
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
                                          if(jsonData[i]['s']=="0")
                                            Text(jsonData[i]['slot'],style: TextStyle(color: Colors.black,
                                                fontSize: 15),
                                            ),if(jsonData[i]['s']=="1")
                                            Text(jsonData[i]['slot']+"\n",style: TextStyle(color: Colors.red,
                                                fontSize: 15),
                                            ),






                                          if(jsonData[i]['s']=="0")

                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Color(0xff4c505b),
                                              child: IconButton(
                                                  color: Colors.black,
                                                  onPressed: ()async {

                                                    SharedPreferences prefs = await SharedPreferences.getInstance();


                                                    prefs.setString("sid",(jsonData[i]['slot_id']).toString());
                                                    prefs.setString("slot",jsonData[i]['slot']);





                                                    Navigator.push(
                                                        context, MaterialPageRoute(builder: (_) =>  pay1home()));








                                                  },
                                                  icon: Icon(
                                                    Icons.arrow_forward,
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






          )
      ),


    );


  }
}




class User{
  final  String name,passd;
  User(this.name,this.passd);
}

