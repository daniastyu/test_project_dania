import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/ui/forgetPassword.dart';

import 'package:moufadala/ui/home.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/ui/sideMenu.dart';


import 'package:moufadala/ui/registerPage.dart';

import 'activateCode.dart';

class LoginPage extends StatefulWidget {
  // SignupPage( {Key key, this.title}) : super(key: key);
  static const String ROUTE_ID = 'LoginPage';
  //final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}
String emptyuser='';
class _LoginPageState extends State<LoginPage> {

 String _email='';
  String status='';
  String text="";
  int visible = 0;
 String _password='';
  Design_app design_app=Design_app();
  Color barColor =Colors.green;
 TextEditingController _phoneController;
 TextEditingController _passwordController;
  bool _passwordVisible = true;
  @override
  void initState() {
    UserGlobal.activation_type="0";
    super.initState();
    // controller  = new ChessBoardController();

    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    //  helper.onLocaleChanged = onLocaleChange;
  }

  final GlobalKey<ScaffoldState> _scaffoldMainstatelogin =
  new GlobalKey<ScaffoldState>();
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  // Method for showing snak bar message
  void _showSnakBarMsg(String msg) {
    _scaffoldMainstatelogin.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }
  @override
  Widget build(BuildContext context) {
    _checkInternetConnectivity();
    return new Scaffold(
        drawer: SideMenu(),
      //backgroundColor: design_app.barColor,
        key: _scaffoldMainstatelogin,
       /* appBar:  AppBar(
          backgroundColor:design_app.barColor ,
          title:  Text(UserGlobal.app_name, style: TextStyle(color:design_app.titleColor)),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: ()  {
              /*   Navigator.pushNamed(
              context,
              ProfilePage.ROUTE_ID);*/

              Navigator.pushNamed(
                  context,
                  Homepage.ROUTE_ID);
            },
          ),

        ),*/
        body:  Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              )),
          constraints: BoxConstraints.expand(),

         // color: design_app.backgroundColor,
          //   color:_design.backgroundColor,
          child: SingleChildScrollView(

            padding: const EdgeInsets.fromLTRB(16.0,0,16.0,0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child:   Center(
                    child: Padding(
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

                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: UserGlobal.screen_heigh/6),
                 Center(child:Text(

                    'الرجاء تسجيل الدخول',
                     style: TextStyle(color:Colors.black)

                 )),
                const SizedBox(height: 24.0),

                const SizedBox(height: 24.0),
                Container(
                  child: TextField(
                    textAlign: TextAlign.left,
                    // textAlign: TextAlign.center,
                    textDirection:TextDirection.ltr,
                    controller: _phoneController,
                    onChanged: (String newVal) {
                      int  maxLength=8;
                      if(newVal.length <= maxLength){
                        text = newVal;
                      }else{
                        _phoneController.value = new TextEditingValue(
                            text: text,
                            selection: new TextSelection(
                                baseOffset: maxLength,
                                extentOffset: maxLength,
                                affinity: TextAffinity.downstream,
                                isDirectional: false
                            ),
                            composing: new TextRange(
                                start: 0, end: maxLength
                            )
                        );
                        _phoneController.text = text;
                      }
                    },
                    decoration: InputDecoration(
                     // textAlign: TextAlign.left,
                      border: const UnderlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      //icon:  Icon(Icons.phone, color: Colors.lightBlue),
                      hintText: ' (9639xxxxxxxx ) ',
                      suffixText: '9639 ',
                      hintTextDirection:TextDirection.rtl,
                      //labelText: 'Mobile',
                      labelText: 'موبايل',
                      //  prefixText: prefix_phone  ,

                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[

                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                TextField(
                //  obscureText:true,
                  obscureText:_passwordVisible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  //  icon:  Icon(Icons.security,color: design_app.titleColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    //hintText: '',
                    labelText: 'كلمة المرور',
                    //prefixText: '',
                  ),
                  keyboardType: TextInputType.text,

                 /* inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],*/
                ),
                 SizedBox(height: 5.0),
                Center(child:Text(

                    emptyuser,
                    style: TextStyle(color:Colors.red)

                )),
                 SizedBox(height: 5.0),
                Row(
                  children: [
                    new Center(
                      child: FlatButton(
                        minWidth: 150.0,
                        shape: RoundedRectangleBorder(

                            borderRadius:BorderRadius.circular(18.0),
                            side: BorderSide(color: design_app.titleColor)
                        ),
                        color: design_app.barColor,
                        child:  Text('تسجيل دخول',style: TextStyle(color:design_app.titleColor,fontSize: 16,)
                          ),
                        onPressed: () {
                          emptyuser='';
                          print(_phoneController.text);

                          if (_phoneController.text.isEmpty|| _passwordController.text.isEmpty||_phoneController.text== null)
                          {
                            try {
                              emptyuser='رقم الهاتف وكلمة المرور لا يمكن أن يكونا فارغين!';
                              setState(() {

                              });

                            }
                            catch(ex)
                            {}
                          } else     if (_phoneController.text.length!=8 )
                          {
                            try {
                              emptyuser='رقم الهاتف يجب ان يكون 8 ارقام !';
                              setState(() {

                              });

                            }
                            catch(ex)
                            {}
                          }

                          else
{
                         setState(() {
                           visible=1;
                           print('---------------------$visible');
                         });}
                        },
                      ),
                    ),
                    Spacer(),
                    new Center(
                      child: new FlatButton(
                        minWidth: 150.0,
                        shape: RoundedRectangleBorder(

                            borderRadius:BorderRadius.circular(18.0),
                            side: BorderSide(color: design_app.titleColor)
                        ),
                        color: Colors.grey[300],
                        child:  Text('استعادة كلمة المرور',style: TextStyle(color:Colors.black,fontSize: 16,)
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context,
                              ForgetPasswordPage.ROUTE_ID);

                        },
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                ),
                StringWidget(str: fetchStr(visible), vi: visible),
               Center(child:Text(

                    'إذا لم يكن لديك حساب، الرجاء تسجيل الاشتراك.',
                    style: TextStyle(color:Colors.black,fontSize: 16,)

                )),
                new Center(
                  child: new FlatButton(
                    minWidth: 200.0,
                    shape: RoundedRectangleBorder(

                        borderRadius:BorderRadius.circular(18.0),
                        side: BorderSide(color: design_app.titleColor)
                    ),
                    color: design_app.barColor,
                    child:  Text('تسجيل اشتراك',style: TextStyle(color:design_app.titleColor,fontSize: 16,)
                    ),
                    onPressed: () {

                     // visible=1;

                        Navigator.pushNamed(
                            context,
                            RegisterPage.ROUTE_ID);

                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                ),

                new Center(
                  child: new FlatButton(
                    minWidth: 200.0,
                    shape: RoundedRectangleBorder(

                        borderRadius:BorderRadius.circular(18.0),
                        side: BorderSide(color: design_app.titleColor)
                    ),
                    color: design_app.barColor,
                    child:  Text('تفعيل اشتراك',style: TextStyle(color:design_app.titleColor,fontSize: 16,)
                    ),
                    onPressed: () {

                      // visible=1;

                      Navigator.pushNamed(context, ActivateCodePage.ROUTE_ID);

                    },
                  ),
                ),
                /*Card(
                  //color:design_app.backgroundColor.withOpacity(0.1) ,
                  color:Color(0xff59198B).withOpacity(0.7),
                    child: Column(
                  children: [
                    Text('أملي... ',style: TextStyle(fontSize: 16,color: Colors.white)),

                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerRight, // Align however you like (i.e .centerRight, centerLeft)
                        child:  Text(' تطبيق يبحث في أسرار وخفايا الحاضر والمستقبل..', style: TextStyle(fontSize: 16,color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerRight, // Align however you like (i.e .centerRight, centerLeft)
                        child:  Text(' قراءة الفنجان - أوراق التاروت - قراءة الكف - قراءة الوجه - تفسير الأحلام - استشارات عاطفية - استشارات روحية - استشارات متنوعة -  أبراج .', style: TextStyle(fontSize: 16,color: Colors.white)),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerRight, // Align however you like (i.e .centerRight, centerLeft)
                        child:  Text(' نجيب على جميع الأسئلة العاطفية والمهنية والمالية والاجتماعية. ', style: TextStyle(fontSize: 16,color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerRight, // Align however you like (i.e .centerRight, centerLeft)
                        child:  Text(' الرد على الأسئلة والاستشارات عن طريق التسجيلات الصوتية. ', style: TextStyle(fontSize: 16,color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerRight, // Align however you like (i.e .centerRight, centerLeft)
                        child:  Text(' يقوم بالرد على الأسئلة والاستشارات أخصائيون وعلماء في الفلك و الأبراج وتفسير الأحلام، ذوو خبرة طويلة في هذه المجالات. ', style: TextStyle(fontSize: 16,color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerRight, // Align however you like (i.e .centerRight, centerLeft)
                        child:  Text(' التزام تام بالحفاظ على السرية والخصوصية. ', style: TextStyle(fontSize: 16,color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerRight, // Align however you like (i.e .centerRight, centerLeft)
                        child:  Text(' يمكن تحميل التطبيق مجاناً من متجري جوجل بلاي وأبل استور. ', style: TextStyle(fontSize: 16,color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerRight, // Align however you like (i.e .centerRight, centerLeft)
                        child:  Text(' أملي تطبيق للترفيه والتسلية ... ', style: TextStyle(fontSize: 16,color: Colors.white)),
                      ),
                    ),

                  ],
                )),*/
                SizedBox(height: 25.0),


              ],
            ),
          ),
        ));
  }




 _loginBtnTap() async {


   {
   //  FocusScope.of(context).requestFocus(FocusNode());
     Services service = new Services();
     String userNamel="9639"+_phoneController.text.toString();
     userNamel="MU"+userNamel;
     String password=_passwordController.text.toString();
     visible=0;
     print('service.result:$userNamel');
    // UserGlobal.userName=userNamel;
   //  await addUserToSF(userNamel,'a','a','a','a');
     //bool login_result=true;
    bool login_result= await service.logIn(userNamel, password,UserGlobal.fbToken);
     //await   Services().xPlay();
     //print('hjkhjkkkkkkkkkkkkkkkk');
     UserGlobal.subscribe=false;
if(login_result==true)
    {
      await FirebaseMessaging.instance
          .subscribeToTopic( ""+UserGlobal.userName);
      if(UserGlobal.ActiveAccount=="1")
      Navigator.pushReplacementNamed(
         context,
         Homepage.ROUTE_ID);
      else if(UserGlobal.ActiveAccount=="0")
        {
          UserGlobal.userName= userNamel;
          Navigator.pushReplacementNamed(
              context,
              ActivateCodePage.ROUTE_ID);
        }
    }
else
  { _showDialog_internet('خطأ',"رقم الهاتف أو كلمة المرور غير صحيحة!");
  }
    // await  Services().getPlayers();
   //  await  Services().xPlay();
     //Fluttertoast
    /* User me = G.dummyUsers[0];
     if (_phoneController.text != 'a') {
       me = G.dummyUsers[1];
     }

     G.loggedInUser = me;
     addUserToSF(me.id,me.name);
     Navigator.pushReplacementNamed(
         context,
         MyHomePage.ROUTE_ID);*/

   }
   return;
 }


  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {

      _showDialog_internet(
          "خطأ في الاتصال بالإنترنت",
          "تحقق من اتصال الإنترنت ، من فضلك"
      );
    }
  }
  _showDialog_internet(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('موافق'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }


  Future<String> fetchStr(int vi) async {

    if(visible==1) {

      await _loginBtnTap();
    }
   // visible=0;

    return ' ' ;


  }
}



class StringWidget extends StatelessWidget {
  final Future<String> str;
  final int vi;

  const StringWidget({Key key, this.str, this.vi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<String>(
        future: str,
        builder: (context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('',style:TextStyle(color:Colors.red[300]));
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else if (snapshot.hasData)
                return Text('${snapshot.data}');
          /* else
                return Text('Press button to start.');*/
          }
          return Text(''); // unreachable
        },
      ),
    );
  }
}
