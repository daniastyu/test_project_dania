import 'package:moufadala/api/user_info.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/ui/home.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/ui/sideMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class ProfilePage extends StatefulWidget {
  // SignupPage( {Key key, this.title}) : super(key: key);
  static const String ROUTE_ID = 'ProfilePage';
  //final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
String emptyuser='';
class _ProfilePageState extends State<ProfilePage> {
 // Future<SharedPreferences> prefs =   SharedPreferences.getInstance() ;
  String _email='';
  int visible = 0;
  String _password='';
  Design_app design_app=Design_app();
  Color barColor =Colors.green;
  TextEditingController _usernameController;
  TextEditingController _emailController;
  TextEditingController _fNameController;
  TextEditingController _lNameController;
  TextEditingController _phoneController;
  List<DropdownMenuItem<ListItem>> _dropdownMenuCountryItems;
  List<ListItem> _dropdownCountryItems =new List<ListItem>();
  User_Info user_info= new User_Info();
  int _value=1;
  int _gender=2;
  var pressed=false;
  String _country='';
  ListItem _selectedCountry;
  String text = "";
void getuserinfo() async{

  // _usernameController.text = user_info.use;
  _emailController.text = UserGlobal.profile_email;
  _fNameController.text = UserGlobal.FName;
  _lNameController.text = UserGlobal.LName;
  _usernameController.text=UserGlobal.userMail;
  print('mobile:'+UserGlobal.mobile);
  if(UserGlobal.mobile.length>12)
  _phoneController.text=UserGlobal.mobile.substring(5,12);
  else
    _phoneController.text=UserGlobal.mobile.substring(4,12);
 // _phoneController.text=UserGlobal.mobile ;
if(UserGlobal.sex!=null)
  _value=int.parse(UserGlobal.sex);
  setState(() {

  });
}
  @override
  void initState() {

    super.initState();
    // controller  = new ChessBoardController();

    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _phoneController= TextEditingController();
    _dropdownCountryItems.add(ListItem(0,'SY'));
    _dropdownCountryItems.add(ListItem(1,'LB'));

    _dropdownMenuCountryItems = buildDropDownMenuItems(_dropdownCountryItems);
    _selectedCountry = _dropdownMenuCountryItems[0].value;
    getuserinfo();
    //getuserinfo();
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
                  padding: const EdgeInsets.only(top:20.0),
                  child: //_scaffoldMainstatelogin
                  Row(
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
                SizedBox(height: UserGlobal.screen_heigh/7),


                Center(child:Text(

                    'معلومات المستخدم',
                    style: TextStyle(color:Colors.black)

                )),
                SizedBox(height: 3,),

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


                const SizedBox(height: 3.0),
                /*Card(
              child: Container(

              //  textDirection: TextDirection.rtl,
                child:Directionality( // add this
                  textDirection: TextDirection.ltr,
                  child: CountryListPick(
                    appBar: AppBar(
                      backgroundColor: design_app.barColor,
                      title: Text('choose country',textAlign: TextAlign.center,),
                      centerTitle:  true
                    ),

                    // if you need custome picker use this
                     /*pickerBuilder: (context, CountryCode countryCode) {
                       return Row(
                         children: [
                           Image.asset(
                             countryCode.flagUri,
                            package: 'country_list_pick',
                           ),
                           Text(countryCode.code),
                          Text(countryCode.dialCode),
                         ],
                       );
                     },*/

                    theme: CountryTheme(

                      isShowFlag: true,
                      isShowTitle: true,
                      isShowCode: true,
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
                Center(child:Text(

                    emptyuser,
                    style: TextStyle(color:Colors.red)

                )),
                SizedBox(height: 5.0),
                new Center(
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
                      /*minWidth: 200.0,
                      shape: RoundedRectangleBorder(

                          borderRadius:BorderRadius.circular(18.0),
                          side: BorderSide(color: design_app.titleColor)
                      ),
                      color: design_app.barColor,*/
                      child:  Text('تعديل',style: TextStyle(color:design_app.titleColor)
                      ),
                      onPressed: () {
                        emptyuser='';

                        if (_usernameController.text.isEmpty||_emailController.text.isEmpty|| _fNameController.text.isEmpty||_lNameController.text.isEmpty)
                        {
                          try {
                            setState(() {
                              emptyuser='الرجاء إدخال الاسم، الكنية و البريد الالكتروني! ';
                            });


                          }
                          catch(ex)
                          {}
                        }
                        else
                        {
                          pressed=!pressed;
                          visible=1;
                        setState(() {

                        });}
                      },
                    ),
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
  _update_profile() async {

    {
      FocusScope.of(context).requestFocus(FocusNode());
      Services service = new Services();
     // String userName=_usernameController.text.toString();
      String email=_emailController.text.toString();
      String fName=_fNameController.text.toString();
      String lName=_lNameController.text.toString();
      String phone="9639"+_phoneController.text.toString();
      print(phone);
     // phone=phone;
      // _gender
      // _country

      bool register_result= await service.update_profile(UserGlobal.userName,email,fName,lName,_country,_gender,phone);


      if(register_result==true)
      {
        _showDialog_internet1('تعديل البروفايل ',".تم تعديل المعلومات بنجاح");
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


  Future<String> fetchStr(int vi) async {


    if(visible==1) {

      await _update_profile();
      pressed=!pressed;
      //update_profile
    }
    visible=2;
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
           else
                return Text(' ');
          }
          return Text(' '); // unreachable
        },
      ),
    );
  }
}
