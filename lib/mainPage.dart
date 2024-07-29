import 'package:flutter/material.dart';
import 'package:turf_booking/ipset.dart';
// import 'package:turf_booking/suggesstion.dart';/**/
import 'homePage.dart';
import 'login.dart';
class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }

}

class _MainState extends State<MainPage>{
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TURF"),
      ),
      backgroundColor: Color(0xFF393636),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home")),
          // BottomNavigationBarItem(icon: Icon(Icons.message),title: Text("Suggestions")),

          BottomNavigationBarItem(icon: Icon(Icons.logout),title: Text("Logout")),
        ]
      ),
      body: getBodyWidget(),
    );
  }

  getBodyWidget() {

    print(_currentIndex);
    if(_currentIndex==0)
      {
        return (_currentIndex==0)? HomePage():Container();

      }
    else  if(_currentIndex==1)
    {
      // Navigator.push(context, MaterialPageRoute(builder: (_) => sug()));
      return (_currentIndex==1)?  MyLogin():Container();

    }
    else  if(_currentIndex==2)
    {
      return (_currentIndex==2)? MyLogin():Container();

      Navigator.push(context, MaterialPageRoute(builder: (_) => MyLogin()));

    }
  }

}