import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf_booking/register.dart';
import 'package:turf_booking/homePage.dart';

import 'funtion.dart';
import 'mainPage.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
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
    TextEditingController passController = new TextEditingController();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/ipp.png'), fit: BoxFit.cover),
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
                        'Login',
                        style: TextStyle(color: Colors.black87, fontSize: 33),
                      ),
                    ),
                SizedBox(
                  height: 100,
                ),

                new Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(

                    controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
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
                        labelText: 'username',
                        hintText: 'Enter valid username',

                    ),


                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: passController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },

                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(  borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),),
                        labelText: 'Password',
                        hintText: 'Enter secure password',
                    ),
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sign in',
                      style: TextStyle(
                          fontSize: 27, fontWeight: FontWeight.w700),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                          color: Colors.white,
                          onPressed: ()async {
                            var uname=emailController.text.toString();
                            var passd=passController.text.toString();
                            print(_formKey.currentState!.validate());

                            if (!_formKey.currentState!.validate()) {
                              print("vvvvvvvvvvvvvvvvvvvvvvvvvvvv");
                            }
                            else {
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              print(uname);
                              final ipaddress = prefs.getString('ip') ?? '';
                              var  url =
                                  'http://' + ipaddress + ':5000/login?uname=' + uname + "&password=" +
                                      passd;

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



                              if (output == 'true') {
                                var id = decoded['m'];
                                var type = decoded['type'];
                                if (type == "user") {
                                  SharedPreferences prefs = await SharedPreferences
                                      .getInstance();
                                  prefs.setString("lid", id.toString());
                                  prefs.setString("t", "");
                                  prefs.setString("p", "");


                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (_) => HomePage()));
                                  // Navigator.push(
                                  //     context, MaterialPageRoute(builder: (_) => MainPage()));
                                }


                              }
                              else {
                                print("+++++++++++++++++++");
                                _showToast(context, "invalid username or password");
                              }
                              // });
                            }


                          },
                          icon: Icon(
                            Icons.login,
                          )),
                    )
                  ],
                ),


                // Container(
                //   height: 50,
                //   width: 200,
                //   decoration: BoxDecoration(
                //       color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                //   child: FlatButton(
                //     onPressed: ()
                //     async {
                //
                //
                //     },
                //     child: Text(
                //       'Login',
                //       style: TextStyle(color: Colors.white, fontSize: 20),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 130,
                // ),
                FlatButton(
                  onPressed: (){
                    //TODO FORGOT PASSWORD SCREEN GOES HERE

                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) =>  MyRegister()));
                  },
                  child:
                  Text('New User? Create Account',
                    style: TextStyle(color: Colors.black87, fontSize: 15),
                  ),
                ),



              ],
            ),
          ),

        ),














        // body: Stack(
        //   children: [
        //     Container(),
        //     Container(
        //       padding: EdgeInsets.only(left: 35, top: 130),
        //       child: Text(
        //         'Welcome\nBack',
        //         style: TextStyle(color: Colors.white, fontSize: 33),
        //       ),
        //     ),
        //     SingleChildScrollView(
        //       child: Container(
        //         padding: EdgeInsets.only(
        //             top: MediaQuery.of(context).size.height * 0.5),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Container(
        //               margin: EdgeInsets.only(left: 35, right: 35),
        //               child: Column(
        //                 children: [
        //                   TextFormField(
        //                     controller: emailController,
        //                     validator: (value) {
        //                       if (value == null || value.isEmpty) {
        //                         return 'Please enter username';
        //                       }
        //                       return null;
        //                     },
        //
        //
        //                     style: TextStyle(color: Colors.black),
        //                     decoration: InputDecoration(
        //                         fillColor: Colors.grey.shade100,
        //                         filled: true,
        //                         hintText: "Email",
        //                         border: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                         )),
        //                   ),
        //                   SizedBox(
        //                     height: 30,
        //                   ),
        //                   TextFormField(
        //                     style: TextStyle(),
        //                     obscureText: true,
        //                     controller: passController,
        //                     validator: (value) {
        //                       if (value == null || value.isEmpty) {
        //                         return 'Please enter password';
        //                       }
        //                       return null;
        //                     },
        //                     decoration: InputDecoration(
        //                         fillColor: Colors.grey.shade100,
        //                         filled: true,
        //                         hintText: "Password",
        //                         border: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                         )),
        //                   ),
        //                   SizedBox(
        //                     height: 40,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(
        //                         'Sign in',
        //                         style: TextStyle(
        //                             fontSize: 27, fontWeight: FontWeight.w700),
        //                       ),
        //                       CircleAvatar(
        //                         radius: 30,
        //                         backgroundColor: Color(0xff4c505b),
        //                         child: IconButton(
        //                             color: Colors.white,
        //                             onPressed: () async{
        //
        //
        //                               var uname=emailController.text.toString();
        //                               var passd=passController.text.toString();
        //                               print(uname);
        //
        //                               print(_formKey.currentState!.validate());
        //
        //                               if (!_formKey.currentState!.validate()) {
        //                                 print("vvvvvvvvvvvvvvvvvvvvvvvvvvvv");
        //                               }
        //                               else {
        //                                 SharedPreferences prefs = await SharedPreferences.getInstance();
        //
        //                                 print(uname);
        //                                 final ipaddress = prefs.getString('ip') ?? '';
        //                             var    url =
        //                                     'http://' + ipaddress + ':5000/login?uname=' + uname + "&password=" +
        //                                         passd;
        //
        //                                 print(url);
        //
        //                               var  data = await fetchdata(url);
        //                                 print("================================================================");
        //                                 print(url);
        //                                 //
        //                                 var decoded = jsonDecode(data.replaceAll("'", "\""));
        //                                 print(decoded);
        //                                 print("+++++++++++++++++++++");
        //                                 // setState(() async {
        //                              var   output = decoded['res'].toString();
        //
        //
        //                                 print(
        //                                     "*****************************************************************"+output);
        //
        //
        //
        //                                 if (output == 'true') {
        //                                   var id = decoded['m'];
        //                                   var type = decoded['type'];
        //                                   if (type == "student") {
        //                                     SharedPreferences prefs = await SharedPreferences
        //                                         .getInstance();
        //                                     prefs.setString("lid", id.toString());
        //
        //
        //                                     Navigator.push(
        //                                         context, MaterialPageRoute(builder: (_) => MainPage()));
        //                                   }
        //
        //
        //                                 }
        //                                 else {
        //                                   print("+++++++++++++++++++");
        //                                   _showToast(context, "invalid username or password");
        //                                 }
        //                                 // });
        //                               }
        //
        //
        //                             },
        //                             icon: Icon(
        //                               Icons.arrow_forward,
        //                             )),
        //                       )
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: 40,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       TextButton(
        //                         onPressed: () {
        //                           Navigator.pushNamed(context, 'register');
        //                         },
        //                         child: Text(
        //                           'Sign Up',
        //                           textAlign: TextAlign.left,
        //                           style: TextStyle(
        //                               decoration: TextDecoration.underline,
        //                               color: Color(0xff4c505b),
        //                               fontSize: 18),
        //                         ),
        //                         style: ButtonStyle(),
        //                       ),
        //                       TextButton(
        //                           onPressed: () {},
        //                           child: Text(
        //                             'Forgot Password',
        //                             style: TextStyle(
        //                               decoration: TextDecoration.underline,
        //                               color: Color(0xff4c505b),
        //                               fontSize: 18,
        //                             ),
        //                           )),
        //                     ],
        //                   )
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
