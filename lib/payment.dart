
import 'dart:convert';
import 'dart:ui';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking/ipset.dart';
import 'package:turf_booking/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'funtion.dart';
import 'homePage.dart';
import 'mainPage.dart';

void main()
{
  runApp(pay());
}
class pay extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: sug(),
    );
  }
}
class sug extends StatefulWidget
{
  @override

  _DataFromAPIState createState() =>_DataFromAPIState();

}
List<String> res=[];
class _DataFromAPIState extends State<sug> {
  final fid="",tid="";
  String date="";
  String slot="";
  String rate="";





  TextEditingController acnoController = new TextEditingController();
  TextEditingController ifscController = new TextEditingController();
  TextEditingController pinController = new TextEditingController();
  TextEditingController bankController = new TextEditingController();
  TextEditingController det = new TextEditingController();

  Future <void> createData () async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    date = prefs.getString('d') ?? 'null' ;
    slot=prefs.getString('slot') ?? 'null';
    rate=prefs.getString('rate') ?? '';
det.text=date+" @ "+slot+ "- Amount: "+rate;

    // _showToast(context,date+" "+slot+" "+" "+rate);





  }

  @override
  void initState() {
    super.initState();
    createData(); // Load the saved value when the page is loaded
  }
  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    createData();
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

                  padding: EdgeInsets.only(left: 12,top: 20,right: 22),


                  child:  TextFormField(

                    controller: det,
                    readOnly: true,




                  )


                  // Text(date+" @ "+slot+ "- Amount: "+rate,style: TextStyle(color: Colors.black,
                  //     fontSize: 15),
                  //
                  // ),
                ),

                Container(

                  padding: EdgeInsets.only(left: 12,top: 20,right: 22),


                  child: TextFormField(

                    controller: acnoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Accno';
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
                      labelText: 'Account Number',
                      hintText: 'Enter your Account Number',

                    ),


                  ),

                ),
                Container(

                  padding: EdgeInsets.only(left: 12,top: 20,right: 22),


                  child: TextFormField(

                    controller: ifscController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter IFSC';
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
                      labelText: 'IFSC',
                      hintText: 'Enter your IFSC',

                    ),


                  ),

                ),
                Container(

                  padding: EdgeInsets.only(left: 12,top: 20,right: 22),


                  child: TextFormField(

                    controller: bankController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Bank Name';
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
                      labelText: 'BANK NAME',
                      hintText: 'Enter your Bank Name',

                    ),


                  ),

                ),
                Container(

                  padding: EdgeInsets.only(left: 12,top: 20,right: 22),


                  child: TextFormField(

                    controller: pinController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter PIN';
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
                      labelText: 'PIN',
                      hintText: 'Enter your PIN',

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
                            var accno=acnoController.text.toString();
                            var ifsc=ifscController.text.toString();
                            var bank=bankController.text.toString();
                            var pin=pinController.text.toString();

                            print(_formKey.currentState!.validate());

                            if (!_formKey.currentState!.validate()) {
                              print("vvvvvvvvvvvvvvvvvvvvvvvvvvvv");
                            }
                            else {
                              SharedPreferences prefs = await SharedPreferences.getInstance();


                              final ipaddress = prefs.getString('ip') ?? '';
                              final ffid = prefs.getString('lid') ?? '';
                              final tid = prefs.getString('tid') ?? '';
                              final date = prefs.getString('d') ?? '';
                              final sid = prefs.getString('sid') ?? '';
                              final rate = prefs.getString('rate') ?? '';


                              var  url ='http://' + ipaddress + ':5000/booknow?accno=' + accno+"&lid="+ffid+"&ifsc="+ifsc+"&bank="+bank+"&pin="+pin+"&tid="+tid+"&sid="+sid+"&date="+date+"&rate="+rate;

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










                            }


                          },
                          icon: Icon(
                            Icons.arrow_forward,
                          )),
                    )
                  ],
                ),










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
