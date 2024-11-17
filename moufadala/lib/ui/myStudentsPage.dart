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
import 'package:moufadala/ui/update_linked_Student.dart';
import 'package:moufadala/ui/web_Page.dart';

import 'package:share/share.dart';



import 'package:shared_preferences/shared_preferences.dart';

import 'mofasPage.dart';



//BuildContext context1;

class MyStudentspage extends StatefulWidget {
  static const String ROUTE_ID = 'MyStudentspage';
  @override
  _MyStudentspageState createState() => _MyStudentspageState();
}


class _MyStudentspageState extends State<MyStudentspage> {
  final _formKey = GlobalKey<FormState>();
//  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Design_app design=new Design_app();
  String userLoginName='C';
  Student student=new Student();
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
        .showSnackBar(new SnackBar(content: new Text(msg, style: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.bold),
    ),backgroundColor: Colors.redAccent,));
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
                var pressed=false;
                String branch="";
                for(int i=0;i<UserGlobal.brancheslist.length;i++)
                  {
                    if(UserGlobal.brancheslist[i].ID==notList[index].branch)
                      {
                        branch=UserGlobal.brancheslist[i].Name;
                        break;
                      }
                  }
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
                                    Row(
                                      children: [

                                        Expanded(
                                          flex:7,
                                          child: Container(
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
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "رقم الاكتتاب: "+" "+notList[index].ikt
                                                          ,

                                                          style: TextStyle(
                                                              fontFamily: 'Cairo',
                                                              fontSize: 18.0,
                                                              color: Colors.blueAccent,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Spacer(),
                                                      /*  IconButton(
                                                          iconSize: 25,
                                                          icon: const Icon(
                                                            Icons.info,
                                                            color: Colors.blue,
                                                          ),
                                                          // the method which is called
                                                          // when button is pressed
                                                          onPressed: () {
                                                            setState(
                                                                  () {
                                                                //count++;
                                                              },
                                                            );
                                                          },
                                                        ),*/
                                                        IconButton(
                                                          iconSize: 25,
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            color: Colors.green,
                                                          ),
                                                          // the method which is called
                                                          // when button is pressed
                                                          onPressed: () {
                                                            UserGlobal.sudent=notList[index];
                                                            Navigator.pushReplacementNamed(
                                                                context,
                                                                Update_linked_student_Page.ROUTE_ID);
                                                            //Update_linked_student_Page
                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                       'الاسم:'+" " +notList[index].name
                                                        ,

                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.blue,
                                                            fontFamily: 'Cairo',
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Spacer(),
                                                      IconButton(
                                                        iconSize: 25,
                                                        icon: const Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.red,
                                                        ),
                                                        // the method which is called
                                                        // when button is pressed
                                                        onPressed: () {
                                                          student=notList[index];
                                                          UserGlobal.student_id=notList[index].student_id;
                                                          //  Services().delete_student( UserGlobal.student_id);
                                                          _showDialogNO(title: 'حذف طالب',message: 'هل تريد حذف الطالب:'+notList[index].name);

                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'اسم الفرع:  '
                                                        ,

                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.blue,
                                                            fontFamily: 'Cairo',
                                                            fontWeight: FontWeight.bold),
                                                      ),

                                                      Text(
                                                        branch
                                                        ,

                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.blue,
                                                            fontFamily: 'Cairo',
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ),
                                        ),


                                      ],
                                    ),
                                  notList[index].link_activated=="0" ? new Center(
                                      child: Container(
                                        width: 200.0,
                                        height: 42,
                                        decoration: BoxDecoration(gradient: null,
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: pressed ? Colors.blueAccent :  Design_app().barColor , // if the button is pressed color will be amber if pressed again it'll go back to blue
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0.0, 0.5),
                                                blurRadius: 40.5,
                                              ),
                                            ]),
                                        child: FlatButton(
                                         /* minWidth: 200.0,
                                          shape: RoundedRectangleBorder(

                                              borderRadius:BorderRadius.circular(18.0),
                                              side: BorderSide(color: Design_app().titleColor)
                                          ),
                                          color: Design_app().barColor,*/
                                          child:  Text('تفعيل',style: TextStyle(color:Design_app().titleColor,fontSize: 16,
                                              fontFamily: 'Cairo')
                                          ),
                                          onPressed: () async{
                                            _showSnakBarMsg('جاري التفعيل، الرجاء الانتظار....');
                                            UserGlobal.sudent=notList[index];
                                            UserGlobal.student_id=notList[index].student_id;
                                            UserGlobal.activation_type="1";

                                           // resend_student_code( String user_name,String student_id,String ikt,String branch,

                                           bool result= await Services().resend_student_code( UserGlobal.userName,notList[index].student_id, notList[index].ikt, notList[index].branch,
                                               );
                                           if(result)
                                            Navigator.pushNamed(
                                                context,
                                                ActivateCodePage.ROUTE_ID);
                                           else
                                             _showSnakBarMsg("حدث خطأ");
                                            }


                                        ),
                                      ),
                                    ):SizedBox(),
                                   /* notList[index].student_mofa_code=="0" || notList[index].student_mofa_code==null? new Center(
                                      child: FlatButton(
                                          minWidth: 200.0,
                                          shape: RoundedRectangleBorder(

                                              borderRadius:BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.redAccent)
                                          ),
                                          color: Colors.redAccent,
                                          child:  Text('توليد الرمز',style: TextStyle(color:Design_app().titleColor,fontSize: 16,
                                              fontFamily: 'Cairo')
                                          ),
                                          onPressed: () async{

                                            UserGlobal.new_url="";
                                            UserGlobal.student_id=notList[index].student_id;
                                         //   await Services().get_student_code(notList[index].student_id);
                                            await showProgress(context,notList[index].student_id);
                                            setState(() {

                                            });
                                          }

                                      ),
                                    ):SizedBox(),
                                    notList[index].student_mofa_code=="0" || notList[index].student_mofa_code==null?SizedBox(): new Center(
                                      child: FlatButton(
                                          minWidth: 200.0,
                                          shape: RoundedRectangleBorder(

                                              borderRadius:BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.redAccent)
                                          ),
                                          color: Colors.redAccent,
                                          child:  Text('نتيحة المفاضلة',style: TextStyle(color:Design_app().titleColor,fontSize: 16,
                                              fontFamily: 'Cairo')
                                          ),
                                          onPressed: () async{

                                            UserGlobal.new_url="";
                                            UserGlobal.student_id=notList[index].student_id;
                                          //  get_student_result
                                            //   await Services().get_student_code(notList[index].student_id);
                                            await showProgress_result(context,notList[index].student_id);
                                            _showDialog_internet('نتيحة المفاضلة للطالب : '+ notList[index].name ,UserGlobal.message);

                                          }

                                      ),
                                    ),*/


                                  ],
                                ),


                              ),
                            ),
                            onTap: () {
                              String type="1";

                            //  UserGlobal.branche=notList[index];
                              //http://mohe.gov.sy/mofa/?IKT=????&City=????&Branch=???&StdID=???&StdCode=???&MType=??&Stype=??
                              if(notList[index].link_activated=="1")
                              {UserGlobal.new_url= UserGlobal.mofas.MofaURL+"?IKT="+notList[index].ikt+"&City="+notList[index].city+"&StdID="+notList[index].student_id;
                              UserGlobal.new_url+="&StdCode="+notList[index].student_mofa_code+"&MType="+ UserGlobal.mofas.MofaType.toString();
                              Navigator.pushNamed(context, Web_Page.ROUTE_ID);}
                              else
                                {
                                  UserGlobal.activation_type="1";
                                  Navigator.pushNamed(
                                      context,
                                      ActivateCodePage.ROUTE_ID);
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
                          child: Text('إضافة طالب' ,
                            style: TextStyle(color: Colors.white,fontFamily: 'Cairo',
                                fontSize: 20,fontWeight: FontWeight.bold),),
                        )),
                    onTap: () async{

                      Navigator.pushNamed(context, Register_student_Page.ROUTE_ID);
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

  void _showDialogNO({String title, String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            width: double.infinity,
           // height: 50,
            // color: design.barColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.redAccent,
              boxShadow: [
                BoxShadow(color: Colors.redAccent, spreadRadius: 3),
              ],
            ),
            child:  Text(title, textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Colors.white,fontFamily: 'Cairo'),
            ),
          ),
          content:  SizedBox(

        height: 100,
            child: Text("$message !",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,fontFamily: 'Cairo'),),
          ),
          actions: <Widget>[

            // usually buttons at the bottom of the dialog
            Container(
              height: 30,
             // color: design.barColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.redAccent,
                boxShadow: [
                  BoxShadow(color: Colors.redAccent, spreadRadius: 3),
                ],
              ),
              child: new FlatButton(
                child:
                new Text("نعم",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,fontFamily: 'Cairo', color:  Colors.white)),

                onPressed: () async {
                  // _resetGame();
                  Navigator.of(context).pop();
                  await Services().delete_student(UserGlobal.student_id,student.ikt,student.branch);
                  setState(() {

                  });

                },
              ),
            ),

            Container(
              height: 30,
              // color: design.barColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(color: Colors.blue, spreadRadius: 3),
                ],
              ),
              child: new FlatButton(
                child:
                new Text("لا",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,fontFamily: 'Cairo', color:  Colors.white)),

                onPressed: () async {
                  // _resetGame();
                  Navigator.of(context).pop();


                },
              ),
            ),
           // Spacer(),
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

