import 'package:moufadala/global/userGlobal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/ui/home.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/ui/sideMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timer_button/timer_button.dart';



class ActivateCodePage extends StatefulWidget {
  // SignupPage( {Key key, this.title}) : super(key: key);
  static const String ROUTE_ID = 'ActivateCode';
  //final String title;

  @override
  _ActivateCodePageState createState() => _ActivateCodePageState();
}
String emptyuser='';
class _ActivateCodePageState extends State<ActivateCodePage> {
  Future<SharedPreferences> prefs =   SharedPreferences.getInstance() ;
  String _email='';
  String status='';
  int visible = 0;

  Design_app design_app=Design_app();
  Color barColor =Colors.green;
  TextEditingController _codeController;
  TextEditingController _phoneController;

  bool _passwordVisible = true;
  @override
  void initState() {
    super.initState();
    // controller  = new ChessBoardController();

    _codeController = TextEditingController();
    _phoneController= TextEditingController();
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
                fit: BoxFit.fill,
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
                  child:   Row(
                    children: [

                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.grey,
                          size: 35,
                        ),
                        // onPressed: () => _scaffoldMainstate.currentState.openEndDrawer(),
                        onPressed: () => _scaffoldMainstatelogin.currentState.openDrawer(),
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

                          },
                        ),
                      )


                    ],
                  ),
                ),
                SizedBox(height: 65),
                Center(child:Text(

                    'الرجاء إدخال الرمز',
                    style: TextStyle(color:Colors.black)

                )),
               /* const SizedBox(height: 24.0),
                TextField(
                  textAlign: TextAlign.left,
                  // textAlign: TextAlign.center,
                  textDirection:TextDirection.ltr,
                  controller: _phoneController,
                  decoration: InputDecoration(

                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    //icon:  Icon(Icons.phone, color: Colors.lightBlue),
                    hintText: '963xxxxxxxxx(963944233037 ) ',
                    //labelText: 'Mobile',
                    labelText: 'موبايل',
                    //  prefixText: prefix_phone  ,

                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[

                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                ),*/
                const SizedBox(height: 24.0),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  //  icon:  Icon(Icons.email, color: design_app.titleColor),
                    labelText: 'الرمز',
                  ),
                  keyboardType: TextInputType.number,

                ),
                const SizedBox(height: 24.0),

                Center(child:Text(

                    emptyuser,
                    style: TextStyle(color:Colors.red)

                )),
                SizedBox(height: 5.0),
                new Center(
                  child: FlatButton(
                    minWidth: 200.0,
                    shape: RoundedRectangleBorder(

                        borderRadius:BorderRadius.circular(18.0),
                        side: BorderSide(color: design_app.titleColor)
                    ),
                    color: design_app.barColor,
                    child:  Text('تغعيل',style: TextStyle(color:design_app.titleColor,fontSize: 16,)
                    ),
                    onPressed: () {
                      emptyuser='';

                      if (_codeController.text.isEmpty||_codeController.text== null)
                      {
                        try {
                          setState(() {
                            emptyuser='الرجاء ادخال الرمز!';
                          });


                        }
                        catch(ex)
                        {}
                      }
                      else
                      visible=1;
                      setState(() {

                      });
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                ),
                StringWidget(str: fetchStr(visible), vi: visible),

                Row(
                  children: [
                    Expanded(
                        flex:2,
                        child: Text(' ')),
                    Expanded(
                      flex:5,
                      child: new TimerButton(

                        label: "إعادة ارسال الرمز",
                        timeOutInSeconds: 60,
                        onPressed: () async{

                          bool res= false;

                          if( UserGlobal.activation_type=="0")
                            res= await Services().resend_code(UserGlobal.userName);
                          else
                          {
                           /* res=await Services().register_student(UserGlobal.userName, UserGlobal.sudent.city,
                                UserGlobal.userName, UserGlobal.sudent.ikt, UserGlobal.sudent.branch,
                                UserGlobal.sudent.branch, UserGlobal.sudent.m, UserGlobal.sudent.p, national_number);*/
                                        /*
                                        resend_student_code( String email,String user_name,String city,String ikt,String branch,String branch_type,
                                              String mobile,String passport,String national_number)
                                         */
                            res= await Services().resend_student_code( UserGlobal.userName,UserGlobal.sudent.student_id,
                                UserGlobal.sudent.ikt, UserGlobal.sudent.branch
                            );

                          }
                          //await   Services().xPlay();
                          //print('hjkhjkkkkkkkkkkkkkkkk');

                          if(res==true)
                          {
                            _showDialog_internet('إرسال الرمز',"تم إعادة ارسال الرمز بنجاح الرجاء الانتظار!");
                          }
                          else
                          { _showDialog_internet('خطأ',"لم تتم عملية الارسال !");
                          }

                        },
                       // disabledColor: design_app.barColor,
                        disabledColor:  Colors.red,
                        color: Colors.red[300],
                        disabledTextStyle: new TextStyle(fontSize: 16.0),
                        activeTextStyle:
                        new TextStyle(fontSize: 16.0, color: Colors.white),
                        buttonType: ButtonType.FlatButton,

                      ),
                    ),
                    Expanded(
                        flex:2,
                        child: Text(' ')),
                  ],
                ),

                SizedBox(height: 25.0),


              ],
            ),
          ),
        ));
  }


  addUserToSF(String utoken, String name,String uid,String mail,String fbUser_name) async {
    final prefs = await SharedPreferences.getInstance();
    //  print('+++++++++++$name');
    prefs.setString('UID', uid);
    prefs.setString('UserName', name);
    prefs.setString('Useremail', mail);
    prefs.setString('usertoken',utoken);
    prefs.setString('fbUser_name',fbUser_name);
  }

  _loginBtnTap() async {

    {
      //FocusScope.of(context).requestFocus(FocusNode());
      Services service = new Services();
      String code=_codeController.text.toString();
      String username=   _phoneController.text.toString();
      username=  UserGlobal.userName;;
      print('service.result:$code');

print('UserGlobal.activation_type:'+UserGlobal.activation_type);

      //bool login_result=false;
      bool login_result=false;
      if( UserGlobal.activation_type=="0")
       login_result= await service.activate(username,code, UserGlobal.fbToken);
      else
        {
          login_result= await service.activate_student( UserGlobal.userName ,code);
        }
      //await   Services().xPlay();
      //print('hjkhjkkkkkkkkkkkkkkkk');
          ;
      if(login_result==true)
      { Navigator.pushReplacementNamed(
          context,
          Homepage.ROUTE_ID);
      }
      else
      { _showDialog_internet('خطأ',"الرمز المدخل غير صحيح!");
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
    visible=0;
    setState(() {

    });

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
