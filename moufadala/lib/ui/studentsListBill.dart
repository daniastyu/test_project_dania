import 'dart:convert';
import 'dart:developer';


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:moufadala/UI/sideMenu.dart';
import 'package:moufadala/api/serviceClass.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:moufadala/ui/activateCode.dart';
import 'package:moufadala/ui/bottom_list.dart';
import 'package:moufadala/ui/home.dart';
import 'package:moufadala/ui/register_student.dart';
import 'package:moufadala/ui/student_bill.dart';
import 'package:moufadala/ui/update_linked_Student.dart';
import 'package:moufadala/ui/web_Page.dart';

import 'package:share/share.dart';



import 'package:shared_preferences/shared_preferences.dart';

import 'mofasPage.dart';



//BuildContext context1;

class StudentsListBillpage extends StatefulWidget {
  static const String ROUTE_ID = 'StudentBillpage';
  @override
  _StudentBillpageState createState() => _StudentBillpageState();
}


class _StudentBillpageState extends State<StudentsListBillpage> {
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








  GlobalKey<ScaffoldState> _scaffoldMainstate =
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
  _showDialog_internet(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text(title),
            content: SizedBox(
              height: 100,
              child: Column(

                children: [
                  Text(title, style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 14,fontWeight: FontWeight.normal)),
                  Text(text, style: TextStyle(color: Colors.redAccent,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            actions: <Widget>[
              //Spacer(),
              FlatButton(
                child: Text('موافق'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // Spacer(),
            ],
          );
        }
    );
  }

  Widget listViewBranchesWidget(List<Student> notList) {

    if(notList.length==0)
    {
      return Container(
          height: 100,
          width: double.infinity,
          color: Colors.grey[100],
          child:Center(child: Text('لا يوجد طلاب ')));
    }
    else
      //print('-----------------${notList.length}');
      return Container(
        padding: const EdgeInsets.all(15.0),
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
                      child:
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // color: Colors.blue.withOpacity(0.3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.blue, spreadRadius: 1),
                              ],
                            ),
                            /*decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new NetworkImage(notList[index].Icon),
                                      fit: BoxFit.cover,
                                    )),*/
                            //color:Color(0xff0071BC),//0071BC
                            child:
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      //  top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                                    ),
                                    // color: Colors.grey[200].withOpacity(0.3),
                                  ),

                                  padding: const EdgeInsets.only(left:1.0,right: 5),
                                  child:
                                  Container(

                                    child: Column(
                                      children: [
                                        Container(
                                          width:double.infinity,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              //  top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                              // top: BorderSide(width: 1.0, color: Colors.grey),
                                                bottom: BorderSide(width: 1.0, color: Colors.grey)
                                            ),
                                            // color: Colors.grey[200].withOpacity(0.3),
                                          ),
                                          child:      Center(
                                            child: Text(
                                              "رقم الاكتتاب: "+" "+notList[index].ikt
                                              ,

                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 18.0,
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'الاسم:'+" " +notList[index].name
                                          ,

                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.blue,
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),


                                ),




                              ],
                            ),


                          ),
                        ),
                        onTap: () {

                          UserGlobal.sudent=notList[index];
UserGlobal.student_id=notList[index].student_id;
                          Navigator.pushNamed(
                              context,
                              Student_Billpage.ROUTE_ID);

                        },

                      ),






                    ),
                  ),

                );
              }),
        ),
      );
  }

  Future<Student_code> get_student_code(String student_id) async {
    Services s =Services();
    Student_code ss=await s.get_student_code(student_id);
    if(ss.STUDENT_CODE==null) {
      // UserGlobal.message = s.messsage;
      _showSnakBarMsg( s.messsage);
    }

    return ss;

  }

  Future<Student_code> get_student_result(String student_id) async {
    Services s =Services();
    Student_code ss=await s.get_student_result(student_id);
    if(ss.RESULT==null) {

      // UserGlobal.message = s.messsage;
      _showSnakBarMsg( s.messsage);
    }
    else
    {UserGlobal.message=ss.RESULT;
      //   _showSnakBarMsg( UserGlobal.message);
    }

    return ss;

  }
  Future<void> showProgress_result(BuildContext context,String student_id) async {
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(get_student_result(student_id), message: Text('جاري الحصول على النتيجة.....')),
    );
    //_showDialog_internet('نتيحة المفاضلة ' ,UserGlobal.message);




  }
  Future<void> showProgress(BuildContext context,String student_id) async {
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(get_student_code(student_id), message: Text('جاري الحصول على الرمز.....')),
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
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25.0,left: 25,bottom: 5,top:5),
                  child: InkWell(
                    child: Container(
                        height: 75 ,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent,
                          boxShadow: [
                            BoxShadow(color: Colors.redAccent, spreadRadius: 3),
                          ],
                        ),
                        //color: Colors.redAccent,
                        child:  Center(
                          child: Text(' اختر طالب ' ,
                            style: TextStyle(color: Colors.white,fontFamily: 'Cairo',
                                fontSize: 20,fontWeight: FontWeight.bold),),
                        )),
                    onTap: (){
                      //Navigator.pushNamed(context, Register_student_Page.ROUTE_ID);
                    },
                  ),
                ),
              ),
              //  SizedBox(height: UserGlobal.screen_heigh/7),
              /*FlatButton(
                minWidth: 250.0,
                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: design.titleColor)
                ),

                color: C,
                child: Text('إضافة طالب',
                    style: TextStyle(color: design.titleColor, fontSize: 18)
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, Register_student_Page.ROUTE_ID);
/*setState(() {

});*/
                },
              ),*/
              Expanded(
                flex:8,
                child:  FutureBuilder(
                    future:  Services().getStudentsList() ,
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? listViewBranchesWidget(snapshot.data)
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
