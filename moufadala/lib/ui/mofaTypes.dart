import 'dart:convert';
import 'dart:developer';


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
import 'package:moufadala/ui/preparingYear.dart';

import 'package:share/share.dart';



import 'package:shared_preferences/shared_preferences.dart';

import 'mofasPage.dart';



//BuildContext context1;

class MofaTypespage extends StatefulWidget {
  static const String ROUTE_ID = 'MofaTypespage';
  @override
  _MofaTypespageState createState() => _MofaTypespageState();
}


class _MofaTypespageState extends State<MofaTypespage> {
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




  @override
  void initState() {

    UserGlobal.fbUser_name=UserGlobal.userName;

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

  Widget listViewBranchesWidget(List<Branches> notList) {

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
        padding: const EdgeInsets.all(5.0),
        child: AnimationLimiter(
          child: ListView.builder(
              itemCount: notList.length,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1500),
                  child:SlideAnimation(
                    verticalOffset: 300.0,
                    child: ScaleAnimation(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            InkWell(
                              child: Container(

                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new NetworkImage(notList[index].Icon),
                                      fit: BoxFit.cover,
                                    )),
                                //color:Color(0xff0071BC),//0071BC
                                child:
                                Row(
                                  children: [

                                    Expanded(
                                      flex:7,
                                      child: Container(
                                        padding: const EdgeInsets.only(left:1.0,right: 5),
                                        child:
                                        Center(
                                          child: Text(
                                            notList[index].Name
                                            ,

                                            style: TextStyle(
                                                fontSize: 24.0,
                                                color: Colors.white,
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),


                                      ),
                                    ),
                                    Expanded(
                                      flex:4,
                                      child: Container(
                                          width:double.infinity,

                                          // height: 100,
                                          height: 65,

                                          child: Text('')

                                      ),
                                    )

                                  ],
                                ),


                              ),
                              onTap: () async{
                                UserGlobal.branche=notList[index];
                              if(index<3)
                                Navigator.pushNamed(
                                    context,
                                    MofasPage.ROUTE_ID);
                              else if(index==3||index==4)
                                {
                                  List<Mofas> mofa=await Services().getMofasList(UserGlobal.branche.ID);
                                  UserGlobal.mofas=mofa[0];
                                  print( UserGlobal.mofas.MofaName);
                                  UserGlobal.mType=notList[index].ID.toString();
                                  //Navigator.pushNamed(context, StudentsToCompresionpage.ROUTE_ID);
                                  Navigator.pushNamed(context, PreparingYearPage.ROUTE_ID);
                                }
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





                          ],
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

    return new   Scaffold(
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
                  padding: const EdgeInsets.only(top:5.0,bottom: 5),
                  child:   Row(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.grey,
                            size: 50,
                          ),
                          // onPressed: () => _scaffoldMainstate.currentState.openEndDrawer(),
                          onPressed: () => _scaffoldMainstate.currentState.openDrawer(),
                        ),
                      ),


                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            width:90,
                            height: 90,
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
                            Navigator.pushNamed(context, Homepage.ROUTE_ID);
                          },
                        ),
                      )

                    ],
                  ),
                ),
              ),
              //  SizedBox(height: UserGlobal.screen_heigh/7),

              Expanded(
              flex:8,
                child:  Center(
                  child: FutureBuilder(
                      future:  Services().getBranchesList() ,
                      builder: (context, snapshot) {
                        return snapshot.data != null
                            ? listViewBranchesWidget(snapshot.data)
                            : Center(child: CircularProgressIndicator());
                      }),
                ),
              ),
              /*Expanded(
                  flex:2,
                  child:Bottom_List()

              )*/
            ],


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

