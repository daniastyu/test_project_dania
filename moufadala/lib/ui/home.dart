import 'dart:convert';
import 'dart:developer';


import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moufadala/main.dart';
import 'package:moufadala/ui/notificationArchive.dart';
import 'package:moufadala/ui/sideMenu.dart';
import 'package:moufadala/api/serviceClass.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:moufadala/ui/bottom_list.dart';
import 'package:moufadala/ui/mofaTypes.dart';

import 'package:share/share.dart';



import 'package:shared_preferences/shared_preferences.dart';

import 'mofasPage.dart';



//BuildContext context1;

class Homepage extends StatefulWidget {
  static const String ROUTE_ID = 'homep';
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
//  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final check_notification = ValueNotifier<String>("0");
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



  void getMofadala_notifications() async{

    List<NotificationArchive> temp=await Services().checkMofadala_notifications(0);

    int alnashra=0;
    try {
      alnashra =temp.length;
    }
    catch(e)
    {}
    check_notification.value=alnashra.toString();

  }

  @override
  void initState() {

    UserGlobal.fbUser_name=UserGlobal.userName;

    print(UserGlobal.fbUser_name);
    getMofadala_notifications();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        var data = message.data;
        RemoteNotification notification = message.notification;
        /* AndroidNotification android = message.notification?.android;
      print('notification${ notification.title}   ${message.data}');
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,

          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: android?.smallIcon,
            ),
          ),
          // payload: "MyOrderPage"
        );
      }*/

        // print(notification['title'] + ": " + notification['body']+" ---"+data.toString());
          _showSnakBarMsg(notification.title + ": " + notification.body);
        if(data['message'] !=null)
        {
          print(data['message']);
          /*var requestId=data['message'].toString().split("@#&");
          //request
          if(requestId!=null) {
            if (requestId[1] == "request")
            {
              print(requestId[1]+"requestId[2]"+requestId[2]);
              if (requestId[2] != null) {

                RequestSClassGeneral.request =RequestSClass();
                try {
                  RequestSClassGeneral.request.request_id =
                      requestId[2].toString();
                  print(RequestSClassGeneral.request.request_id.toString());
                }
                catch(t)
                { print(t.toString());}
                Navigator.pushNamed(context,  MyOrderDetaisPage.ROUTE_ID);

                //   Navigator.pushNamed(context, MyOrderPage.ROUTE_ID);
              }
            }
            else  if (requestId[1] == "media")
            {
              if (requestId[2] != null) {
                UserGlobal.nid=requestId[2] ;
                UserGlobal.search_key ='';
                UserGlobal.search_Category = '';
                //  UserGlobal.search_Category = '';
                UserGlobal.search_Source = '1';
                UserGlobal.notificationSearchtype="1";
                Navigator.pushNamed(
                    context,
                    SearchNotificationResultPage.ROUTE_ID);

              }
            }

          }*/
        }

      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;

      AndroidNotification android = message.notification?.android;
      print('notification${ notification.title}   ${message.data}');
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,

          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: android?.smallIcon,
            ),
          ),
          // payload: "MyOrderPage"
        );

        _showSnakBarMsg(notification.title + ": " + notification.body);
        var data = message.data;

        // print(notification['title'] + ": " + notification['body']+" ---"+data.toString());
        //  _showSnakBarMsg(notification.title + ": " + notification.body);
        if(data['message'] !=null)
        {
          print(data['message']);
          var requestId=data['message'].toString().split("@#&");
          //request
        /*  if(requestId!=null) {
            if (requestId[1] == "request")
            {
              print(requestId[1]+"requestId[2]"+requestId[2]);
              if (requestId[2] != null) {

                RequestSClassGeneral.request =RequestSClass();
                try {
                  RequestSClassGeneral.request.request_id =
                      requestId[2].toString();
                  print(RequestSClassGeneral.request.request_id.toString());
                }
                catch(t)
                { print(t.toString());}
                Navigator.pushNamed(context,  MyOrderDetaisPage.ROUTE_ID);

                //   Navigator.pushNamed(context, MyOrderPage.ROUTE_ID);
              }
            }
            else  if (requestId[1] == "media")
            {
              if (requestId[2] != null) {
                UserGlobal.nid=requestId[2] ;
                UserGlobal.search_key ='';
                UserGlobal.search_Category = '';
                //  UserGlobal.search_Category = '';
                UserGlobal.search_Source = '1';
                UserGlobal.notificationSearchtype="1";
                Navigator.pushNamed(
                    context,
                    SearchNotificationResultPage.ROUTE_ID);

              }
            }

          }*/
        }

      }

    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;

      var data = message.data;


      // print(notification['title'] + ": " + notification['body']+" ---"+data.toString());
        _showSnakBarMsg(notification.title + ": " + notification.body);
      /*if(data['message'] !=null)
      {
        print(data['message']);
        var requestId=data['message'].toString().split("@#&");
        //request
        if(requestId!=null) {
          if (requestId[1] == "request")
          {
            print(requestId[1]+"requestId[2]"+requestId[2]);
            if (requestId[2] != null) {

              RequestSClassGeneral.request =RequestSClass();
              try {
                RequestSClassGeneral.request.request_id =
                    requestId[2].toString();
                print(RequestSClassGeneral.request.request_id.toString());
              }
              catch(t)
              { print(t.toString());}
              Navigator.pushNamed(context,  MyOrderDetaisPage.ROUTE_ID);

              //   Navigator.pushNamed(context, MyOrderPage.ROUTE_ID);
            }
          }
          else  if (requestId[1] == "media")
          {
            if (requestId[2] != null) {
              UserGlobal.nid=requestId[2] ;
              UserGlobal.search_key ='';
              UserGlobal.search_Category = '';
              //  UserGlobal.search_Category = '';
              UserGlobal.search_Source = '1';
              UserGlobal.notificationSearchtype="1";
              Navigator.pushNamed(
                  context,
                  SearchNotificationResultPage.ROUTE_ID);

            }
          }

        }
      }*/
    });



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
        .showSnackBar(new SnackBar(content: new Text(msg,    style: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.bold),
    ),backgroundColor: Colors.redAccent,));
  }

  _onShareWithEmptyOrigin(BuildContext context) async {
    await Share.share("text");
  }

  Widget listViewBranchesWidget(List<Gen_news> notList) {

    if(notList.length==0)
    {
      return Container(
          height: 100,
          width: double.infinity,
          color: Colors.grey[100],
          child:Center(child: Text('لا توجد أخبار ')));
    }
    else
      //print('-----------------${notList.length}');
      return Container(
        padding: const EdgeInsets.all(15.0),
        child: AnimationLimiter(
          child: ListView.builder(
              itemCount: notList.length,
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1500),
                  child:SlideAnimation(
                    verticalOffset: 300.0,
                    child: ScaleAnimation(
                      child:
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey[300], spreadRadius: 3),
                                  ],
                                ),

                               /* decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new NetworkImage(notList[index].Icon),
                                      fit: BoxFit.cover,
                                    )),*/
                               // color:Color(0xff0071BC),//0071BC
                                child:
                                Row(
                                        children: [

                                          Expanded(
                                            flex:7,
                                            child: Container(
                                              padding: const EdgeInsets.only(left:1.0,right: 5),

                                              child:
                                              Column(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      notList[index].subject
                                                      ,

                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  Text(notList[index].description,
                                                      style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black,
                                                     // fontWeight: FontWeight.bold
                                                      ))
                                                ],
                                              ),


                                            ),
                                          ),
                                          Expanded(
                                            flex:4,
                                            child: Container(
                                                width:double.infinity,

                                                // height: 100,
                                                height: 75,

                                                child: notList[index].photo!=null||notList[index].photo!=""?
                                                Image.network(notList[index].photo):
                                                Image.asset(
                                                  'assets/logo3.png',
                                                 // width: 600.0,
                                               //   height: 240.0,
                                                  fit: BoxFit.cover,
                                                ),
                                               // AssetImage('assets/logo3.png'),


                                            ),
                                          )

                                        ],
                                      ),


                                  ),
                    onTap: () {
                  /*              if(notList[index].url!=""||notList[index].url!=null)
                     { UserGlobal.new_url=notList[index].url;
                      Navigator.pushNamed(
                            context,
                            MofasPage.ROUTE_ID);}*/
                      /*  if(notList[index].description!=null || notList[index].description!='')
                                  { NewsClass newsDetails =new NewsClass();
                                  newsDetails.title=notList[index].subject;
                                  newsDetails.photo=notList[index].photo;
                                  newsDetails.url=notList[index].url;
                                  newsDetails.details=notList[index].description;
                                  UserGlobal.newsDetails=newsDetails;
                                  Navigator.pushNamed(
                                      context,
                                      NewsDetailsPage.ROUTE_ID);}*/

                    },

                            ),
                          ),






                    ),
                  ),
                );
              }),
        ),
      );
  }



  @override
  Widget build( context) {

    return new WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;       },
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
                flex:2,
                child: Padding(
                  padding: const EdgeInsets.only(top:15.0,bottom: 15),
                  child:   Row(
                    children: [

                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.grey,
                          size: 40,
                        ),
                       // onPressed: () => _scaffoldMainstate.currentState.openEndDrawer(),
                        onPressed: () => _scaffoldMainstate.currentState.openDrawer(),
                      ),


                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top:12.0,left: 10),
                        child: InkWell(
                          child: Container(
                            width:45,
                            height: 45,

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                //  image: AssetImage("assets/icons/setting.png"),
                                image: AssetImage("assets/bell.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child:   ValueListenableBuilder(
                                //TODO 2nd: listen playerPointsToAdd
                                valueListenable: check_notification,
                                builder: (context, value, widget) {
                                  if( value == '0') return Text(' ');
                                  else
                                    //TODO here you can setState or whatever you need
                                    return Container(
                                      decoration: new BoxDecoration(

                                          color:Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)
                                          )
                                      ),

                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(

                                          child: Text(
                                            //TODO e.g.: create condition with playerPointsToAdd's value
                                              value == ' '
                                                  ? ' '
                                                  : check_notification.value.toString() , style: TextStyle(fontSize:12,color:Colors.white)),
                                        ),
                                      ),
                                    );
                                },
                              ),
                            ),
                          ),
                          onTap: () {
                            check_notification.value='0';

                            UserGlobal.Notification_type='0';
                            Navigator.pushNamed(
                                context,
                                NotificationPage.ROUTE_ID);
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                flex:3,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0),
                  child: InkWell(
                    child: Container(
                      //width:300,
                     // height: 120,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage('assets/logo3.png'),
                            fit: BoxFit.contain,
                          )),
                      child: Center(
                        //SpinKitRotatingCircle
                        child: Text('   '),
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
              ),

              //  SizedBox(height: UserGlobal.screen_heigh/7),
              Expanded(
                flex:1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 0),
                  child:Container(
                    //height: 100,
                    width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          //  image: AssetImage("assets/icons/setting.png"),
                          image: AssetImage("assets/icons/CompraionNews.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text(' '))
                  /*FlatButton(
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(

                          borderRadius:BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.redAccent)
                      ),
                      color: Colors.redAccent,
                      child:  Text('المفاضلة الالكترونية',style: TextStyle(color:Design_app().titleColor,fontSize: 20)
                      ),
                      onPressed: () {
                        UserGlobal.activation_type="1";
                        Navigator.pushNamed(
                            context,
                            MofaTypespage.ROUTE_ID);
                      }

                  ),*/
                ),
              ),
              Expanded(
                flex:7,
                child:  FutureBuilder(
                    future:  Services().gen_news() ,
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? listViewBranchesWidget(snapshot.data)
                          : Center(child: CircularProgressIndicator());
                    }),
              ),
              Expanded(
                flex:3,
                child:Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Bottom_List(),
                )

              )
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

