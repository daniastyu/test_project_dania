import 'package:moufadala/global/userGlobal.dart';
import 'package:moufadala/ui/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/ui/home.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/ui/sideMenu.dart';
import 'package:connectivity/connectivity.dart';
import 'package:moufadala/ui/registerPage.dart';

class ForgetPasswordPage extends StatefulWidget {
  // SignupPage( {Key key, this.title}) : super(key: key);
  static const String ROUTE_ID = 'ForgetPasswordPage';
  //final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}
String emptyuser='';
class _LoginPageState extends State<ForgetPasswordPage> {

  String _email='';
  int visible = 0;
  String text = "";
  String _password='';
  Design_app design_app=Design_app();
  bool _passwordVisible=false;
  Color barColor =Colors.green;
  TextEditingController _phoneController;
  TextEditingController _passwordController;
  String status='';
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
  void initState() {
    super.initState();
    // controller  = new ChessBoardController();

    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    //  helper.onLocaleChanged = onLocaleChange;
  }
  @override
  Widget build(BuildContext context) {
    _checkInternetConnectivity();
    return
        new Scaffold(
        drawer: SideMenu(),
    //backgroundColor: design_app.barColor,
    key: _scaffoldMainstatelogin,
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
                          width:100,
                          height: 100,
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
                //SizedBox(height: 80),
                Center(child:Text(

                    'يرجى كتابة رقم الهاتف الخاص بك، وسيتم تغيير كلمة المرور وإرسالها إلى رقم الهاتف الخاص بحسابك',
                    style: TextStyle(color:Colors.black,fontSize: 18)

                )),
                const SizedBox(height: 24.0),

                const SizedBox(height: 24.0),
                TextField(
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

                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: ' (9639xxxxxxxx ) ',
                    suffixText: '9639 ',
                    //labelText: 'Mobile',
                    labelText: 'موبايل',
                    //  prefixText: prefix_phone  ,

                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[

                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 24.0),

                Center(child:Text(

                    emptyuser,
                    style: TextStyle(color:Colors.red)

                )),
                SizedBox(height: 2.0),
                new Center(
                  child: new FlatButton(
                    minWidth: 250,

                      shape: RoundedRectangleBorder(

                          borderRadius:BorderRadius.circular(18.0),
                          side: BorderSide(color: design_app.barColor)
                      ),
                    color: design_app.barColor,
                    child:  Text('استعادة وارسال الى رقم الهاتف ',style: TextStyle(color:design_app.titleColor,fontSize: 16,)
                    ),
                    onPressed: () {
                      if (_phoneController.text.isEmpty ||_phoneController.text== null||_phoneController.text== '')
                      {
                        try {
                          //   emptyuser='اسم المستخدم  لا يمكن أن يكون فارغ!';
                          /*setState(() {

        });*/

                          _showDialog_internet('خطأ',"رقم الهاتف  لا يمكن أن يكون فارغ!'");
                        }
                        catch(ex)
                        {}
                      }
                      else{
                        visible=1;
                        setState(() {

                        });}
                    },
                  ),
                ),
                SizedBox(height: 15.0),

                StringWidget(str: fetchStr(visible), vi: visible),
                Center(child:Text(

                    'إذا لم يكن لديك حساب، الرجاء تسجيل الاشتراك في التطبيق.',
                    style: TextStyle(color:Colors.black,fontSize: 16,)

                )),
                new Center(
                  child:  FlatButton(
                    minWidth: 250,

                    shape: RoundedRectangleBorder(

                        borderRadius:BorderRadius.circular(18.0),
                        side: BorderSide(color: design_app.barColor)
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



              ],
            ),
          ),
        ));
  }

  _loginBtnTap() async {
    emptyuser='';




    {
      FocusScope.of(context).requestFocus(FocusNode());
      Services service = new Services();
      String userNamel="9639"+_phoneController.text.toString();

      userNamel="MU"+userNamel;
      bool login_result= await service.reset_password(userNamel);
      //await   Services().xPlay();
      //print('hjkhjkkkkkkkkkkkkkkkk');
          ;
      if(login_result==true)
      { Navigator.pushReplacementNamed(
          context,
          LoginPage.ROUTE_ID);
      }
      else
      {
        if(service.result!=null||service.result!='')
          _showDialog_internet('خطأ', service.result);
        else
          _showDialog_internet('خطأ',"اسم المستخدم  غير صحيحة!");

        // service.result
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
    visible=0;

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
              return CircularProgressIndicator(backgroundColor: Colors.white,);
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
