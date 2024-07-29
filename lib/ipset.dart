import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking/register.dart';

import 'funtion.dart';
import 'login.dart';
import 'mainPage.dart';

class ipset extends StatefulWidget {
  const ipset({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<ipset> {
  @override


  void _showToast(BuildContext context,String cnt) {
    final scaffold = ScaffoldMessenger.of(context);
    String mycnt = cnt;
    scaffold.showSnackBar(
      SnackBar(
        content: Text(mycnt.toString()),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();


    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/ipb.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Form(
          key: _formKey,

          child: Center(

            child: new Column(

              mainAxisSize: MainAxisSize.max,


              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>
              [
                Container(
                  padding: EdgeInsets.only(left: 12,),
                  child: Text(
                    'GOLAZO',
                    style: TextStyle(color: Colors.white, fontSize: 35,),
                  ),
                ),
                SizedBox(
                  height: 230,
                ),

                new Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(

                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ip';
                      }
                      return null;
                    },
                      style: TextStyle(
                        color: Colors.white, // Change the text color
                      ),
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelText: 'ip',
                        labelStyle: TextStyle(
                          color: Colors.white, // Set the label text color
                        ),
                      hintText: 'Enter  ip',
                        hintStyle: TextStyle(
                      color: Colors.white, // Change the hint text color
                    )

                    ),


                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Set ip',
                      style: TextStyle(
                          fontSize: 27, fontWeight: FontWeight.w700,color: Colors.white),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                          color: Colors.white,
                          onPressed: ()async {
                            var ip=emailController.text.toString();

                            print(_formKey.currentState!.validate());

                            if (!_formKey.currentState!.validate()) {
                              print("vvvvvvvvvvvvvvvvvvvvvvvvvvvv");
                            }
                            else {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString("ip",ip.toString());
                              Navigator.push(context, MaterialPageRoute(builder: (_) => MyLogin()));



                              // });
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
          ),

        ),















      ),
    );
  }
}
