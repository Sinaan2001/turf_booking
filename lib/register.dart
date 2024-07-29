import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'funtion.dart';
import 'login.dart';
import 'mainPage.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

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

  @override
  Widget build(BuildContext context) {
    TextEditingController fnameController = new TextEditingController();
    TextEditingController lnameController = new TextEditingController();

    TextEditingController emailController = new TextEditingController();
    TextEditingController phoneController = new TextEditingController();
    TextEditingController unameController = new TextEditingController();
    TextEditingController passController = new TextEditingController();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/imd.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body:SingleChildScrollView(child:
    Form(
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
                    'Register',
                    style: TextStyle(color: Colors.black, fontSize: 28),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                new Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(

                    controller: fnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter First Name';
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
                      labelText: 'First Name',
                      hintText: 'Enter valid name',

                    ),


                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                new Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(

                    controller: lnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter First Name';
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
                      labelText: 'Last Name',
                      hintText: 'Enter valid name',

                    ),


                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 15),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.toString());
                      print("================");
                      print(emailValid);
                      print(value.toString());
                      print("*****************");
                      if (value == null || value.isEmpty ) {
                        return 'Please enter your emailid';
                      }
                      else if( !emailValid)
                      {
                        return 'Enter a valid email';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(  borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),),
                      labelText: 'Email',
                      hintText: 'Enter secure email',
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 15),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      bool emailValid = RegExp(r"^[9876][0-9]{9}").hasMatch(value.toString());
                      print("================");
                      print(emailValid);
                      print(value.toString());
                      print("*****************");
                      if (value == null || value.isEmpty ) {
                        return 'Please enter your Phone Number';
                      }
                      else if( !emailValid)
                      {
                        return 'Enter a valid Phone No';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(  borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),),
                      labelText: 'Phone No',
                      hintText: 'Enter secure Phone no',
                    ),
                  ),

                ),
    Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 15),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: unameController,
                    validator: (value) {
                      bool emailValid = RegExp(r"^[a-zA-Z0-9!@#$%^&*]{6,20}").hasMatch(value.toString());
                      print("================");
                      print(emailValid);
                      print(value.toString());
                      print("*****************");
                      if (value == null || value.isEmpty ) {
                        return 'Please enter your Username';
                      }
                      else if( !emailValid)
                      {
                        return 'Enter a valid username';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(  borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),),
                      labelText: 'Username',
                      hintText: 'Enter secure Username',
                    ),
                  ),

                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 15),
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
                      hintText: 'Enter password',
                    ),
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 27, fontWeight: FontWeight.w700),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: IconButton(
                          color: Colors.white,
                          onPressed: ()async {
                            var name=fnameController.text.toString();
                            var lname=lnameController.text.toString();

                            var email=emailController.text.toString();
                            var phone=phoneController.text.toString();
                            var uname=unameController.text.toString();
                            var passd=passController.text.toString();
                            print(_formKey.currentState!.validate());

                            if (!_formKey.currentState!.validate()) {
                              print("vvvvvvvvvvvvvvvvvvvvvvvvvvvv");
                            }
                            else {
                              SharedPreferences prefs = await SharedPreferences.getInstance();


                              final ipaddress = prefs.getString('ip') ?? '';
                              var  url =
                                  'http://' + ipaddress + ':5000/register?name=' + name + "&password=" + passd+"&email="+email+"&lname="+lname+"&uname="+uname+"&phone="+phone;

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

                                     Navigator.push(
                                         context, MaterialPageRoute(builder: (_) => MyLogin()));

                              }
                              //   var id = decoded['m'];
                              //   var type = decoded['type'];
                              //   if (type == "user") {
                              //     SharedPreferences prefs = await SharedPreferences
                              //         .getInstance();
                              //     prefs.setString("lid", id.toString());
                              //
                              //

                              //
                              //
                              // }
                              // else {
                              //   print("+++++++++++++++++++");
                              //   _showToast(context, "invalid username or password");
                              // }
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
                // FlatButton(
                //   onPressed: (){
                //     //TODO FORGOT PASSWORD SCREEN GOES HERE
                //
                //     Navigator.push(
                //         context, MaterialPageRoute(builder: (_) =>  MyRegister()));
                //   },
                //   child:
                //   Text('New User? Create Account',
                //     style: TextStyle(color: Colors.blue, fontSize: 15),
                //   ),
                // ),



              ],
            ),
          ),

        ),
        // body: Stack(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.only(left: 35, top: 30),
        //       child: Text(
        //         'Create\nAccount',
        //         style: TextStyle(color: Colors.white, fontSize: 33),
        //       ),
        //     ),
        //     SingleChildScrollView(
        //       child: Container(
        //         padding: EdgeInsets.only(
        //             top: MediaQuery.of(context).size.height * 0.28),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Container(
        //               margin: EdgeInsets.only(left: 35, right: 35),
        //               child: Column(
        //                 children: [
        //                   TextField(
        //                     style: TextStyle(color: Colors.white),
        //                     decoration: InputDecoration(
        //                         enabledBorder: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                           borderSide: BorderSide(
        //                             color: Colors.white,
        //                           ),
        //                         ),
        //                         focusedBorder: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                           borderSide: BorderSide(
        //                             color: Colors.black,
        //                           ),
        //                         ),
        //                         hintText: "Name",
        //                         hintStyle: TextStyle(color: Colors.white),
        //                         border: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                         )),
        //                   ),
        //                   SizedBox(
        //                     height: 30,
        //                   ),
        //                   TextField(
        //                     style: TextStyle(color: Colors.white),
        //                     decoration: InputDecoration(
        //                         enabledBorder: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                           borderSide: BorderSide(
        //                             color: Colors.white,
        //                           ),
        //                         ),
        //                         focusedBorder: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                           borderSide: BorderSide(
        //                             color: Colors.black,
        //                           ),
        //                         ),
        //                         hintText: "Email",
        //                         hintStyle: TextStyle(color: Colors.white),
        //                         border: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                         )),
        //                   ),
        //                   SizedBox(
        //                     height: 30,
        //                   ),
        //                   TextField(
        //                     style: TextStyle(color: Colors.white),
        //                     obscureText: true,
        //                     decoration: InputDecoration(
        //                         enabledBorder: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                           borderSide: BorderSide(
        //                             color: Colors.white,
        //                           ),
        //                         ),
        //                         focusedBorder: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(10),
        //                           borderSide: BorderSide(
        //                             color: Colors.black,
        //                           ),
        //                         ),
        //                         hintText: "Password",
        //                         hintStyle: TextStyle(color: Colors.white),
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
        //                         'Sign Up',
        //                         style: TextStyle(
        //                             color: Colors.white,
        //                             fontSize: 27,
        //                             fontWeight: FontWeight.w700),
        //                       ),
        //                       CircleAvatar(
        //                         radius: 30,
        //                         backgroundColor: Color(0xff4c505b),
        //                         child: IconButton(
        //                             color: Colors.white,
        //                             onPressed: () {},
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
        //                           Navigator.pushNamed(context, 'login');
        //                         },
        //                         child: Text(
        //                           'Sign In',
        //                           textAlign: TextAlign.left,
        //                           style: TextStyle(
        //                               decoration: TextDecoration.underline,
        //                               color: Colors.white,
        //                               fontSize: 18),
        //                         ),
        //                         style: ButtonStyle(),
        //                       ),
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

        )
      ),
    );
  }
}
