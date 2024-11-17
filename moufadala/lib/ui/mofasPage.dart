import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moufadala/UI/sideMenu.dart';
import 'package:moufadala/api/serviceClass.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:moufadala/ui/bottom_list.dart';
import 'package:moufadala/ui/home.dart';
import 'package:moufadala/ui/myStudentsPage.dart';
import 'package:moufadala/ui/register_student.dart';
import 'package:moufadala/ui/studentsToComprion.dart';
import 'package:moufadala/ui/web_Page.dart';

import 'package:share/share.dart';



import 'package:shared_preferences/shared_preferences.dart';



//BuildContext context1;

class MofasPage extends StatefulWidget {
  static const String ROUTE_ID = 'MofasPage';
  @override
  _MofasPageState createState() => _MofasPageState();
}


class _MofasPageState extends State<MofasPage> {
  final _formKey = GlobalKey<FormState>();
//  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Design_app design=new Design_app();
  String userLoginName='C';

  String fb_token='';
  String status='';
  //#7e2a9a
  Color barColor =Colors.black;
  Color backgroundColor =Colors.green;
  Color text_Color =Colors.black;
  Color text_BackgroundColor =Colors.green;

  bool get_topic = false;
  @override
  bool get wantKeepAlive => true;

  List<Mofas> mofasList= new List<Mofas>();
void getMofas() async
{
  mofasList=await Services().getMofasList(UserGlobal.branche.ID);
  setState(() {

  });
}

  @override
  void initState() {

    UserGlobal.fbUser_name=UserGlobal.userName;
    getMofas();
    print(UserGlobal.fbUser_name);
    super.initState();


  }








  final GlobalKey<ScaffoldState> _scaffoldMainstate =
  new GlobalKey<ScaffoldState>();
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  // Method for showing snak bar message
  void _showSnakBarMsg(String msg) {
    _scaffoldMainstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share("text");
  }

  Widget gridViewMofasWidget(List<Mofas> notList) {

    if(notList.length==0)
    {
      return Container(
          height: 100,
          width: double.infinity,
          color: Colors.grey[100],
          child:Center(child: Text('لا توجد فروع ')));
    }
    else
      //print('-----------------${notList.length}');
      return Container(
        //color: Colors.white.withOpacity(0.3),
        child:  GridView.count(
          shrinkWrap: true,
          primary: true,
          crossAxisCount:2 ,

          scrollDirection: Axis.vertical,
          // physics: NeverScrollableScrollPhysics(),
         //crossAxisSpacing:2,
             childAspectRatio: 2,
          children:   mofasList.map((value) {
          //  int index=    mofasList.indexOf(value);
            //print(index);

            return InkWell(
              child: Padding(
               //padding: const EdgeInsets.only(left:5.0,right: 5,top: 5),
               padding: const EdgeInsets.all(4),
                child: Container(
                //  height: 150,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(value.MofaIcon),
                          fit: BoxFit.fill,
                        )),
                  // padding: const EdgeInsets.all(5),
                    child:Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text('')),
                        Expanded(
                            flex: 7,
                            child: Center(
                              //padding: const EdgeInsets.all(1.0),
                              child: Text(value.MofaName!=null?value.MofaName:'' ,
                                style: TextStyle(color: Colors.white,fontFamily: 'Cairo',fontSize: 11),),
                            )),

                      ],
                    )),
              ),
              onTap: () {

                UserGlobal.mofas=value;

              UserGlobal.mType=value.MofaType.toString();
                Navigator.pushNamed(context, StudentsToCompresionpage.ROUTE_ID);
            //    Navigator.pushNamed(context, Register_student_Page.ROUTE_ID);
               //
              //  print(value.url);
                //_launchInBrowser(value.url);
              },
            );
          }).toList(),


        ),

      );
  }



  @override
  Widget build( context) {

    return new WillPopScope(
     /* onWillPop: () async {
        SystemNavigator.pop();
        return false;       },*/
      child: Scaffold(
        //endDrawer: SideMenu(),
        drawer: SideMenu(),
        // backgroundColor: barColor,
        key: _scaffoldMainstate,

        body:   Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              )),
          //color: Colors.white,
          child: Column(

            children: [
              Expanded(
                flex:3,
                child: Padding(
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
                        onPressed: () => _scaffoldMainstate.currentState.openDrawer(),
                      ),


                      Spacer(),
                      Container(
                        padding: const EdgeInsets.all(15.0),
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
                ),
              ),
              //  SizedBox(height: UserGlobal.screen_heigh/7),
//gridViewMofasWidget
           /*   Expanded(
                flex:6,
                child:  gridViewMofasWidget(mofasList),
              ),*/
              Expanded(
                flex:2,
                child: Container(
                  margin: const EdgeInsets.only(top:15.0,bottom: 5,left: 10,right: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(UserGlobal.branche.Icon),
                          fit: BoxFit.fill,
                        )),
                    child: Center(
                      child: Text(UserGlobal.branche.Name,
                        style: TextStyle(color: Colors.white,fontFamily: 'Hacen-Maghreb',fontSize: 24,fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:9,
                child:  FutureBuilder(
                    future:  Services().getMofasList(UserGlobal.branche.ID) ,
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? gridViewMofasWidget(snapshot.data)
                          : Center(child: CircularProgressIndicator());
                    }),
              ),
             /* Expanded(
                  flex:2,
                  child:Bottom_List()

              )*/
            ],


          ),
        ),

      ),
    );
  }

  void _showDialogNO({String title, String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            width: double.infinity,
            color: design.barColor,
            child: new Text(title, textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Colors.white),
            ),
          ),
          content: new Text("$message !"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Container(
              color: design.barColor,
              child: new FlatButton(
                child:
                new Text("Ok",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color:  Colors.white)),

                onPressed: () {
                  // _resetGame();
                  Navigator.of(context).pop();


                },
              ),
            ),

          ],
        );
      },
    );

  }
  _showDialog_imagedetails(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text(title),
            content: Container(child:
            Image.network(
              text,
              fit: BoxFit.fill,
            )
              //Text(text)
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('إغلاق'),
                onPressed: () {
                  Navigator.of(context).pop();

                },
              )
            ],
          );
        }
    );
  }

  getUserFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenValue = '';

    tokenValue = prefs.getString('UserName') ?? null;
    userLoginName = tokenValue;
    print('please log in:$userLoginName');


    return tokenValue;
  }

}

