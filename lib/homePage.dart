import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:turf_booking/login.dart';
import 'package:turf_booking/search_turf.dart';
import 'package:turf_booking/view_match.dart';



import 'course.dart';
import 'history.dart';
import 'mymatch.dart';


class HomePage extends StatelessWidget{
  var services = [
    "SEARCH TURF",
    "VIEW BOOKING",
    "VIEW MATCH",
    "MY MATCH",
    "HISTORY",
    "LOGOUT",




  ];

  var images = [
    "images/sturf.PNG",
    "images/booking.png",
    "images/942037.png",
    "images/my match.jpg",
    "images/history.jpg",
    "images/logout.jpg",

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("TURF"),
    ),
    backgroundColor: Color(0xFF393636),

    body:Padding(

      padding: EdgeInsets.all(10),
      child: GridView.builder(

          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/1.9)
          ),
          itemBuilder: (BuildContext context,int index){
            return Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Image.asset(images[index],height: 77,width: 100,),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child:

                    FlatButton(
                      onPressed: () async {
                        //TODO FORGOT PASSWORD SCREEN GOES HERE

                          if (services[index]=="SEARCH TURF")
                            {
                              SharedPreferences prefs = await SharedPreferences
                                  .getInstance();

                              prefs.setString("t", "");
                              prefs.setString("p", "");
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) =>  st()));
                            }
                        else   if (services[index]=="VIEW BOOKING")
                          {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) =>  course()));
                          }

                          else   if (services[index]=="LOGOUT")
                          {

                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            // prefs.setString("type","ACCOMMODATION");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) =>  MyLogin()));
                          }else   if (services[index]=="MY MATCH")
                          {

                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            // prefs.setString("type","ACCOMMODATION");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) =>  mymatch()));
                          }
                          else   if (services[index]=="VIEW MATCH")
                          {

                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            // prefs.setString("type","ACCOMMODATION");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) =>  view_matchhome()));
                          }
                        else if (services[index]=="HISTORY")
                          {

                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            // prefs.setString("type","ACCOMMODATION");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) =>  history()));
                          }


                      },
                      child:
                      Text(services[index],style: TextStyle(fontSize: 12,fontFamily: "Montserrat",height: 1.0,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),

                    ),



                  )
                ],
              ),
            );
          }
      ),
    )
    );
  }

}