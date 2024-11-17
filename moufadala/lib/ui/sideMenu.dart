
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import 'package:flutter/material.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:moufadala/ui/activateCode.dart';
import 'package:moufadala/ui/changePasswordPage.dart';
import 'package:moufadala/ui/getCompetitionCode.dart';
import 'package:moufadala/ui/home.dart';
import 'package:moufadala/ui/mofaTypes.dart';
import 'package:moufadala/ui/myStudentsPage.dart';
import 'package:moufadala/ui/profilepage.dart';
import 'package:moufadala/ui/resultCompotion.dart';
import 'package:moufadala/ui/studentsListBill.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'loginPage.dart';

class SideMenu extends StatelessWidget {
  Design_app design=new Design_app();
  logout() async {

    await FirebaseMessaging.instance
        .unsubscribeFromTopic(UserGlobal.userName);
    UserGlobal.userName=null;
    final prefs = await SharedPreferences.getInstance();
    //  print('+++++++++++$name');++
    prefs.setString('Useremail', null);
    prefs.setString('UserName', null);
    prefs.setString('usertoken',null);
    prefs.setString('UserName',null);
    //UserGlobal.userName = prefs.getString('UserName') ?? null;

    /* await FirebaseMessaging.instance
        .unsubscribeFromTopic( ""+UserGlobal.fbUser_name);
    UserGlobal.userName='-C';
    UserGlobal.userMail = '-C';
    // UserGlobal.userName= prefs.getString('UserName') ?? null;;
    UserGlobal.userToken='-C';
    UserGlobal.activeAccount="0";

 */
  }
  Future<void> showProgress(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(logout(), message: Text('جاري تسجيل الخروج....')),
    );
    //showResultDialog(context, result);
  }
  @override
  Widget build(BuildContext context) {
    print('UserGlobal.userName--------------------------');
    print(UserGlobal.userName);
    return Drawer(

      child: Container(
        color: Colors.white.withOpacity(0.9),
        //color: design.barColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: InkWell(
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left:65.0, right: 65),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),

                          image: DecorationImage(
                            image: AssetImage("assets/logo3.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        //   child: Text(' ')
                      ),
                    )),
                onTap: (){
                  Navigator.pushNamed(context, Homepage.ROUTE_ID);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left:50.0, right: 50),
              child: Container(

                  decoration: BoxDecoration(
                    border: Border(
                      // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                      bottom: BorderSide(width: 1.0, color: design.barColor),
                    ),
                    //color: Colors.white,
                  ),
                  child: Text(' ')
              ),
            ),

            /*ListTile(
            //  leading: Icon(Icons.home,color:Colors.white),
              title: Center(child: Text('الرئيسية' ,style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 18,fontWeight: FontWeight.normal),)),
              onTap: () => {

                Navigator.pushNamed(context, Homepage.ROUTE_ID)
              },
            ),*/
            ListTile(
              //  leading: Icon(Icons.home,color:Colors.white),
              title: Center(child: Text('سجلات الطلاب المرتبطة' ,style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
              onTap: ()  {
                if( UserGlobal.userName==null)
                {
                  UserGlobal.activation_type="0";
                  Navigator.pushReplacementNamed(
                      context,
                      LoginPage.ROUTE_ID);

                }
                else {

                  Navigator.pushNamed(context, MyStudentspage.ROUTE_ID);
                }
              },
            ),

            ListTile(
              //  leading: Icon(Icons.home,color:Colors.white),
              title: Center(child: Text('الحصول على رمز التقدم' ,style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
              onTap: ()  {
                if( UserGlobal.userName==null)
                {

                  Navigator.pushReplacementNamed(
                      context,
                      LoginPage.ROUTE_ID);

                }
                else
                  Navigator.pushNamed(context, GetCompetitionCodepage.ROUTE_ID);

                //Navigator.pushNamed(context, MyStudentspage.ROUTE_ID);
                //GetCompetitionCodepage
              },
            ),

            ListTile(
              //  leading: Icon(Icons.home,color:Colors.white),
              title: Center(child: Text('التقدم للمفاضلة' ,
                style: TextStyle(color: design.barColor,fontFamily: 'Cairo',
                    fontSize: 18,fontWeight: FontWeight.normal),)),
              onTap: ()  {

                UserGlobal.activation_type="1";


                Navigator.pushNamed(
                    context,
                    MofaTypespage.ROUTE_ID);
              },
            ),

            ListTile(
              //  leading: Icon(Icons.home,color:Colors.white),
              title: Center(child: Text('نتائج المفاضلة' ,
                style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
              onTap: ()  {
                if( UserGlobal.userName==null)
                {

                  Navigator.pushReplacementNamed(
                      context,
                      LoginPage.ROUTE_ID);

                }
                else
                  Navigator.pushNamed(context, ResultCompetitionpage.ROUTE_ID);
              },
            ),

            ListTile(
              //  leading: Icon(Icons.home,color:Colors.white),
              title: Center(child: Text('الفواتير المرتبطة' ,
                style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
              onTap: ()  {
                if( UserGlobal.userName==null)
                {

                  Navigator.pushReplacementNamed(
                      context,
                      LoginPage.ROUTE_ID);

                }
                else {
                  Navigator.pushNamed(context, StudentsListBillpage.ROUTE_ID);

                }
              },
            ),

            ( UserGlobal.userName!=null&& UserGlobal.userName!=''&& UserGlobal.userName!='-C'&& UserGlobal.userName!='C')?
            ListTile(
              // leading: Icon(Icons.verified_user,color:Colors.white),
              title: Center(child: Text('إدارة الملف الشخصي' ,style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal))),
              onTap: () => {
                Navigator.pushNamed(context, ProfilePage.ROUTE_ID)
              },
            ):SizedBox.fromSize(),
            UserGlobal.activeAccount=="0"? ListTile(
              //   leading: Icon(Icons.border_color,color:Colors.white),
              title: Center(child: Text('تفعيل الحساب',style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal))),
              onTap: ()  {
                Navigator.pushNamed(context, ActivateCodePage.ROUTE_ID);
              },
            ):SizedBox(),


            ( UserGlobal.userName!=null&& UserGlobal.userName!=''&& UserGlobal.userName!='-C'&& UserGlobal.userName!='C')? ListTile(
              //   leading: Icon(Icons.border_color,color:Colors.white),
              title: Center(child: Text('تعديل كلمة المرور',style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal))),
              onTap: ()  {
                Navigator.pushNamed(context, ChangePawwprdPage.ROUTE_ID);
              },
            ):SizedBox.fromSize(),



            ListTile(
              // leading: Icon(Icons.exit_to_app,color:Colors.white),
              title: Center(child: Text(
                  ( UserGlobal.userName!=null)?'تسجيل خروج':'تسجيل دخول',
                  style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal))),
              onTap: ()  async{
                if  ( UserGlobal.userName!=null&& UserGlobal.userName!='')
                {

                  try {
                    UserGlobal.ActiveAccount = "-1";
                    //Navigator.pop(context);

                    await showProgress(context);
                    Navigator.pushReplacementNamed(context, LoginPage.ROUTE_ID);
                  }catch(e)
                  {}

                }
                else
                {
                  UserGlobal.ActiveAccount="-1";
                  Navigator.pushNamed(context, LoginPage.ROUTE_ID);
                }
              },
            ),
            ( UserGlobal.userName!=null&& UserGlobal.userName!=''&& UserGlobal.userName!='-C'&& UserGlobal.userName!='C'
            )?
            SizedBox.fromSize():
            ListTile(
              //   leading: Icon(Icons.border_color,color:Colors.white),
              title: Center(child: Text('تفعيل الحساب',style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal))),
              onTap: ()  {
                // Navigator.pushNamed(context, ActivateCodePage.ROUTE_ID);
              },
            ),
            /* ListTile(
              //  leading: Icon(Icons.home,color:Colors.white),
              title: Center(child: Text('موقع الوزارة' ,
                style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
              onTap: ()  {
                //_launchInBrowser(UserGlobal.links.ministry);
              },
            ),
            ListTile(
              //  leading: Icon(Icons.home,color:Colors.white),
              title: Center(child: Text('موقع المفاضلة' ,
                style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
              onTap: ()  {
               // _launchInBrowser(UserGlobal.links.mofa);
              },
            ),*/
            Center(
              child: InkWell(
                child: Container(
                    height:50,child: Row(
                  children: [
                    // SizedBox(width: 100,),
                    Expanded(
                      flex: 5,
                      // padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(' رقم الهاتف: ',style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Center(child: Text(UserGlobal.links.phone!=null?UserGlobal.links.phone
                        :"",style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
                    ),
                  ],
                )),
                onTap: () {
                  print("tapped on container");
                  /*try{
                          AppAvailability.launchApp(Platform.isIOS ? "message://" :  "muhammad@gmail.com").then((_) {
                            print("App Email launched!");
                          }).catchError((err) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("App Email not found!")
                            ));
                            print(err);
                          });
                        } catch(e) {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Email App not                 found!")));
                        }*/
                },

              ),
            ),

            Center(
              child: InkWell(
                child: Container(
                    height:50,child: Row(
                  children: [
                    // SizedBox(width: 100,),
                    Expanded(
                      flex: 5,
                      // padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(' البريد الإلكتروني: ',style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Center(child: Text(UserGlobal.links.email!=null?
                      UserGlobal.links.email:"",style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
                    ),
                  ],
                )),
                onTap: () {
                  print("tapped on container");
                  /*try{
                          AppAvailability.launchApp(Platform.isIOS ? "message://" :  "muhammad@gmail.com").then((_) {
                            print("App Email launched!");
                          }).catchError((err) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("App Email not found!")
                            ));
                            print(err);
                          });
                        } catch(e) {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Email App not                 found!")));
                        }*/
                },

              ),
            ),
            /* Center(
              child: InkWell(
                child: Container(
                    height:50,child: Row(
                  children: [
                    // SizedBox(width: 100,),
                    Expanded(
                      flex: 5,
                      // padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(' الدعم الفني: ',style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Center(child: Text("support@media.sy",style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
                    ),
                  ],
                )),
                onTap: () {
                  print("tapped on container");
                  /*try{
                          AppAvailability.launchApp(Platform.isIOS ? "message://" :  "muhammad@gmail.com").then((_) {
                            print("App Email launched!");
                          }).catchError((err) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("App Email not found!")
                            ));
                            print(err);
                          });
                        } catch(e) {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Email App not                 found!")));
                        }*/
                },

              ),
            ),
            Center(
              child: InkWell(
                child: Container(
                    height:50,child: Row(
                  children: [
                    // SizedBox(width: 100,),
                    Expanded(
                      flex: 5,
                      // padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(' الموقع الالكتروني: ',style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Center(child: Text("https://media.sy",style: TextStyle(color: design.barColor,fontFamily: 'Cairo',fontSize: 16,fontWeight: FontWeight.normal),)),
                    ),
                  ],
                )),
                onTap: () async{
                  const url = "https://media.sy";
                  if (await canLaunch(url))
                  await launch(url);
                  else
                  // can't launch url, there is some error
                  throw "Could not launch $url";
                },

              ),
            ),*/


          ],
        ),
      ),
    );

  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        //forceSafariVC: false,
        //forceWebView: false,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    }
  }
}