

import 'package:connectivity/connectivity.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/ui/activateCode.dart';
import 'package:moufadala/ui/home.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/ui/sideMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class RegisterPage extends StatefulWidget {
  // SignupPage( {Key key, this.title}) : super(key: key);
  static const String ROUTE_ID = 'RegisterPage';
  //final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}
String emptyuser='';
class _RegisterPageState extends State<RegisterPage> {
  Future<SharedPreferences> prefs =   SharedPreferences.getInstance() ;
  String _email='';
  int visible = 0;
  String status='';
  String _password='';
  Design_app design_app=Design_app();
  Color barColor =Colors.green;
  TextEditingController _usernameController;
  TextEditingController _emailController;
  TextEditingController _fNameController;
  TextEditingController _lNameController;
  TextEditingController _phoneController;
  TextEditingController _confirmPasswordController;
  TextEditingController _passwordController;
  bool _passwordVisible = true;
  bool _confPasswordVisible = true;
  String prefix_phone='963';
  String text = "";
  List<DropdownMenuItem<ListItem>> _dropdownMenuCountryItems;
  List<ListItem> _dropdownCountryItems =new List<ListItem>();
  int _value=1;
  int _gender=2;
  String _country='sy';
  ListItem _selectedCountry;
  @override
  void initState() {
    super.initState();
    // controller  = new ChessBoardController();

    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController= TextEditingController();
    _dropdownCountryItems.add(ListItem(0,'SY'));
    _dropdownCountryItems.add(ListItem(1,'LB'));

    _dropdownMenuCountryItems = buildDropDownMenuItems(_dropdownCountryItems);
    _selectedCountry = _dropdownMenuCountryItems[0].value;
    //  helper.onLocaleChanged = onLocaleChange;
  }
  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

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
                image: new AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              )),
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(

            padding: const EdgeInsets.fromLTRB(16.0,0,16.0,0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child:    Center(

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
                  )
                ),
                SizedBox(height: UserGlobal.screen_heigh/7),

                Center(child:Text(

                    'الرجاء إدخال المعلومات اللازمة لتسجيل الاشتراك',
                    style: TextStyle(color:Colors.black,fontSize: 16)

                )),
                SizedBox(height: 10,),

                TextField(
                  controller: _fNameController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,


                    labelText: 'الاسم ',
                  ),
                  keyboardType: TextInputType.emailAddress,

                ),
                SizedBox(height: 3,),
                   TextField(
                  controller: _lNameController,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,


                    labelText: 'الكنية ',
                  ),
                  keyboardType: TextInputType.emailAddress,

                ),
                SizedBox(height: 3,),
               TextField(
                    controller: _emailController,
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(

                      border: const UnderlineInputBorder(),
                     filled: true,
                      fillColor: Colors.white,


                      labelText: 'البريد الالكتروني',
                    ),
                    keyboardType: TextInputType.emailAddress,

                  ),


                Card(
                  child:Directionality(
                    textDirection: TextDirection.rtl,
                    child: new TextField(
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
                        //icon:  Icon(Icons.phone, color: Colors.lightBlue),
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
                  ),
                ),

                Card(
                  child: TextField(
                    obscureText:_passwordVisible,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                     // icon:  Icon(Icons.security,color: design_app.titleColor),
                      //hintText: '',
                      hintText: 'على الاقل 6 احرف و/او ارقام ',
                      labelText: 'كلمة المرور',
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
                      //prefixText: '',
                    ),
                    keyboardType: TextInputType.text,

                    /* inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],*/
                  ),
                ),
                const SizedBox(height: 3.0),
                Card(
                  child: TextField(
                    obscureText:_confPasswordVisible,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                     // icon:  Icon(Icons.security,color: design_app.titleColor),
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
                      //hintText: '',
                      labelText: 'تأكيد كلمة المرور',
                      //prefixText: '',
                    ),
                    keyboardType: TextInputType.text,

                    /* inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],*/
                  ),
                ),
              /* Card(
                  child: Container(

                    //  textDirection: TextDirection.rtl,
                    child:Directionality( // add this
                      textDirection: TextDirection.rtl,
                      child: CountryListPick(
                        appBar: AppBar(
                            backgroundColor: design_app.barColor,
                            title: Text('اختر البلد',textAlign: TextAlign.center,),
                            centerTitle:  true
                        ),

                        theme: CountryTheme(

                          isShowFlag: true,
                          isShowTitle: true,
                          isShowCode: false,
                          isDownIcon: true,
                          showEnglishName: true,

                        ),
                        initialSelection: '+963',
                        useUiOverlay: true,
                        // Whether the country list should be wrapped in a SafeArea
                        useSafeArea: false,


                        onChanged: (CountryCode code) {
                          _country=code.name;
                          print(code.name);
                          print(code.code);
                          print(code.dialCode);
                          print(code.flagUri);
                        },
                      ),
                    ),
                  ),
                ),
*/
                const SizedBox(height: 10.0),

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
                    child:  Text('تسجيل اشتراك',style: TextStyle(color:design_app.titleColor,fontSize: 17)
                    ),
                    onPressed: () {

                     // print(phone);
                      if(_fNameController.text==null|| _lNameController.text==null  ||
                          _fNameController.text==""||
                          _lNameController.text==""
                      )
                      { _showDialog_internet('خطأ', 'الرجاء ادخال الحقول بشكل صحيح');}
                      else     if (_phoneController.text.length!=8 )
                      {
                        try {
                          emptyuser='رقم الهاتف يجب انت يكون 8 ارقام !';
                          setState(() {

                          });

                        }
                        catch(ex)
                        {}
                      }
                      else if (_passwordController.text.length<6)
                           {
                             { _showDialog_internet('كلمة المرور', 'الرجاء ادخال  على الاقل 6 احرف و/او ارقام ');}
                           }
                       else if (_passwordController.text!=_confirmPasswordController.text)
                       {
                         { _showDialog_internet('كلمة المرور', 'الرجاء التأكد من تطابق كلمة المرور ');}
                       }

                   else{   visible=1;
                      setState(() {

                      });}
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
  _registerbtn() async {

    {
      FocusScope.of(context).requestFocus(FocusNode());
      Services service = new Services();
   //   String userName=_usernameController.text.toString();
      String email=_emailController.text.toString();
      String fName=_fNameController.text.toString();;
      String lName=_lNameController.text.toString();;
      String password=_passwordController.text;
      String phone="9639"+_phoneController.text;
      UserGlobal.mobile=phone;
      String userName="MU"+phone;
      // _gender
       //_country='sy';

      bool register_result= await service.register(email, userName,fName,lName,_country,password,phone);


      if(register_result==true)
      {
       // UserGlobal.userName=userName;
        _showDialog_ActivateCode('تفعيل الاشتراك',"تم إرسال كود التفعيل، الرجاء تفعيل الاشتراك.");
      }
      else
      { _showDialog_internet('خطأ',service.messsage);
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
  _showDialog_ActivateCode(title, text) {
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
                  Navigator.pushReplacementNamed(
                      context,
                      ActivateCodePage.ROUTE_ID);
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
  addUserToSF(int id, String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('UserName', name);
    prefs.setInt('UserId',id);

  }

  Future<String> fetchStr(int vi) async {

    if(visible==1) {

      await _registerbtn();
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
