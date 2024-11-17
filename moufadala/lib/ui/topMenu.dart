import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:moufadala/ui/home.dart';
import 'package:url_launcher/url_launcher.dart';

class Top_Menu extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldMainstate =
  new GlobalKey<ScaffoldState>();
    Top_Menu({this.scaffoldMainstate }) ;
  @override
  _Top_Menu_State createState() => _Top_Menu_State();
}

class _Top_Menu_State extends State<Top_Menu> {


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top:15.0,bottom: 15),
      child:   Row(
        children: [

          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.grey,
              size: 35,
            ),
            // onPressed: () => _scaffoldMainstate.currentState.openEndDrawer(),
            onPressed: () => this.widget.scaffoldMainstate.currentState.openDrawer(),
          ),


          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              child: Container(
                width:80,
                height: 80,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/logo3.png'),
                      fit: BoxFit.cover,
                    )),
                child: Center(
                  //SpinKitRotatingCircle
                  child: Text('   '),
                ),
              ),
              onTap: (){
                Navigator.pushNamed(context, Homepage.ROUTE_ID);
              },
            ),
          )

        ],
      ),
    )


    ;
  }
}