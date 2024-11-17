import 'package:moufadala/api/user_info.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:moufadala/ui/home.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/ui/sideMenu.dart';

import 'package:connectivity/connectivity.dart';

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class ChangePawwprdPage extends StatefulWidget {
  // SignupPage( {Key key, this.title}) : super(key: key);
  static const String ROUTE_ID = 'ChangePawwprdPage';
  //final String title;

  @override
  _ChangePawwprdPageState createState() => _ChangePawwprdPageState();
}
String emptyuser='';
class _ChangePawwprdPageState extends State<ChangePawwprdPage> {

  String _email='';
  int visible = 0;
  String _password='';
  Design_app design_app=Design_app();
  Color barColor =Colors.green;
  bool _oldPasswordVisible = true;
  bool _newPasswordVisible = true;
  bool _confPasswordVisible = true;
  TextEditingController _OldPasswordontroller;
  TextEditingController _newPassworController;
  TextEditingController _confirmPassworController;

  User_Info user_info= new User_Info();
  int _value=1;
  int _gender=2;
  String _country='';
  ListItem _selectedCountry;


  @override
  void initState() {
    super.initState();
    // controller  = new ChessBoardController();


    _OldPasswordontroller = TextEditingController();
    _newPassworController = TextEditingController();
    _confirmPassworController = TextEditingController();

    //  helper.onLocaleChanged = onLocaleChange;
  }
String status='';
  final GlobalKey<ScaffoldState> _scaffoldMainstatelogin =
  new GlobalKey<ScaffoldState>();
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
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
        /*backgroundColor: design_app.barColor,
        appBar:  AppBar(
          backgroundColor:design_app.barColor ,
          title:  Text(UserGlobal.app_name, style: TextStyle(color:design_app.titleColor)),
          centerTitle: true,

        ),*/
        body:  Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              )),
          constraints: BoxConstraints.expand(),
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
                          color: Colors.white,
                        ),
                        onPressed: () => _scaffoldMainstatelogin.currentState.openDrawer(),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: UserGlobal.screen_heigh/7),
                Center(child:Text(

                    'تعديل كلمة المرور',
                    style: TextStyle(color:Colors.black)

                )),
                SizedBox(height: 3,),

                TextField(
                  obscureText: _oldPasswordVisible,
                  controller: _OldPasswordontroller,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,

                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _oldPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _oldPasswordVisible = !_oldPasswordVisible;
                        });
                      },
                    ),
                    labelText: 'كلمة المرور القديمة ',
                  ),
                  keyboardType: TextInputType.emailAddress,

                ),
                SizedBox(height: 3,),
                TextField(
                  obscureText: _newPasswordVisible,
                  controller: _newPassworController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,

                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _newPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _newPasswordVisible = !_newPasswordVisible;
                        });
                      },
                    ),
                    labelText: 'كلمة المرور الجديدة ',
                  ),
                  keyboardType: TextInputType.emailAddress,

                ),
                SizedBox(height: 3,),
                TextField(
                  obscureText: _confPasswordVisible,
                  controller: _confirmPassworController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _confPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _confPasswordVisible = !_confPasswordVisible;
                        });
                      },
                    ),

                    labelText: 'كلمة المرور الجديدة ',
                  ),
                  keyboardType: TextInputType.emailAddress,

                ),
                SizedBox(height: 3,),

                Center(child:Text(

                    emptyuser,
                    style: TextStyle(color:Colors.red)

                )),
                SizedBox(height: 5.0),
                new Center(
                  child:   FlatButton(
                    minWidth: 200.0,
                   // height: 100,
                    shape: RoundedRectangleBorder(

                        borderRadius:BorderRadius.circular(18.0),
                        side: BorderSide(color: design_app.titleColor)
                    ),
                    color: design_app.barColor,
                    child:  Text('تعديل',style: TextStyle(color:design_app.titleColor)
                    ),
                    onPressed: () {
                      emptyuser='';

                      if (_OldPasswordontroller.text.isEmpty||
                          _confirmPassworController.text.isEmpty||_newPassworController.text.isEmpty)
                      {
                        try {
                          setState(() {
                            emptyuser='الرجاء إدخال البيانات ';
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


              ],
            ),
          ),
        ));
  }
  _update_password() async {

    {
      FocusScope.of(context).requestFocus(FocusNode());
      Services service = new Services();
      String old=_OldPasswordontroller.text.toString();
      String newp=_newPassworController.text.toString();
      String conf=_confirmPassworController.text.toString();

      // _gender
      // _country

      bool update_result= await service.update_password(old, newp,conf);


      if(update_result==true)
      {
        _showDialog_internet1('تعديل كلمة السر ',".تم تعديل كلمة السر بنجاح");
      }
      else
      { _showDialog_internet('خطأ',service.result);
      }
      // await  Services().getPlayers();
      //  await  Services().xPlay();
      //Fluttertoast
      /* User me = G.dummyUsers[0];
     if (_usernameController.text != 'a') {
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
  _showDialog_internet1(title, text) {
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
                  Navigator.pushNamed(
                      context,
                      Homepage.ROUTE_ID);
                },
              )
            ],
          );
        }
    );
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

    if(visible==0) {


    }
    if(visible==1) {

      await _update_password();
      //update_profile
    }
    visible=2;



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


