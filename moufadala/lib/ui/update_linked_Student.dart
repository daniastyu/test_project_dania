import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';


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

import 'package:share/share.dart';



import 'package:shared_preferences/shared_preferences.dart';



//BuildContext context1;

class Update_linked_student_Page extends StatefulWidget {
  static const String ROUTE_ID = 'Update_linked_student_Page';
  @override
  _Update_linked_student_PageState createState() => _Update_linked_student_PageState();
}


class _Update_linked_student_PageState extends State<Update_linked_student_Page> {
  final _formKey = GlobalKey<FormState>();
//  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  bool result=false;
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
  String branch="1";
  List<Mofas> mofasList= new List<Mofas>();
  TextEditingController _emailController;
  TextEditingController _iktController;
  String text = "";
  TextEditingController _phoneController;
  TextEditingController _passportController;
  TextEditingController _nationalNumberController;
  List<ListItem> _dropdownCityItems =new List<ListItem>();
  List<DropdownMenuItem<ListItem>> __dropdownMenuCityItems;
  ListItem _selectedCity;
  List<ListItem> _dropdownTypeItems =new List<ListItem>();
  List<DropdownMenuItem<ListItem>> __dropdownMenuTypeItems;
  ListItem _selectedType;
  List<ListItem> _dropdownCareerItems =new List<ListItem>();
  List<DropdownMenuItem<ListItem>> __dropdownMenuCareerItems;
  ListItem _selectedCareer;
  List<ListItem> _dropdownLitraryItems =new List<ListItem>();
  List<DropdownMenuItem<ListItem>> __dropdownMenuLitraryItems;
  ListItem _selectedLitrary;
  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.Name),
          value: listItem,
        ),
      );
    }
    return items;
  }
  void fillDropDown() async
  {


    for(int i=0;i<UserGlobal.citieslist.length;i++)
    {

      _dropdownCityItems.add(UserGlobal.citieslist[i]);

    }

    for(int i=0;i<UserGlobal.careerslist.length;i++)
    {

      _dropdownCareerItems.add(UserGlobal.careerslist[i]);

    }

    __dropdownMenuTypeItems = buildDropDownMenuItems(UserGlobal.brancheslist);
    _selectedType=__dropdownMenuTypeItems[0].value;

    ListItem a1=ListItem(ID:"2",Name:"أدبي");
    ListItem a2=ListItem(ID:"3",Name:"شرعي");
    _dropdownLitraryItems.add(a1);
    _dropdownLitraryItems.add(a2);


    __dropdownMenuCityItems = buildDropDownMenuItems(_dropdownCityItems);
    _selectedCity = __dropdownMenuCityItems[0].value;
    __dropdownMenuCareerItems = buildDropDownMenuItems(_dropdownCareerItems);
    _selectedCareer= __dropdownMenuCareerItems[0].value;

    __dropdownMenuLitraryItems = buildDropDownMenuItems(_dropdownLitraryItems);
    _selectedLitrary= __dropdownMenuLitraryItems[0].value;


    /*List<ListItem> _dropdownTypeItems =new List<ListItem>();
    List<DropdownMenuItem<ListItem>> __dropdownMenuTypeItems;
    ListItem _selectedType;*/
    setState(() {

    });
  }


  void fill_student_info()
  {
    //_emailController = TextEditingController();
    _emailController.text= UserGlobal.sudent.link_email!=null?UserGlobal.sudent.link_email:"";
    // _iktController = TextEditingController();
    _iktController.text= UserGlobal.sudent.ikt!=null?UserGlobal.sudent.ikt:"";
    //_phoneController = TextEditingController();
    _phoneController.text= UserGlobal.sudent.link_mobile!=null?UserGlobal.sudent.link_mobile.substring (4):"";
    //  _nationalNumberController = TextEditingController();
    _nationalNumberController.text= UserGlobal.sudent.national_number!=null?UserGlobal.sudent.national_number:"";
    // _passportController= TextEditingController();
    // _passportController.text= UserGlobal.sudent.nationality_id!=null?UserGlobal.sudent.nationality_id:"";

    print( 'link_email');
    print(UserGlobal.sudent.link_email);
    setState(() {

    });
  }
  @override
  void initState() {
    //fillDropDown();
    _emailController = TextEditingController();
    //_emailController.text= UserGlobal.sudent.link_email!=null?UserGlobal.sudent.link_email:"";
    _iktController = TextEditingController();
    //_iktController.text= UserGlobal.sudent.ikt!=null?UserGlobal.sudent.ikt:"";
    _phoneController = TextEditingController();
    //_phoneController.text= UserGlobal.sudent.link_mobile!=null?UserGlobal.sudent.link_mobile.substring (4):"";
    _nationalNumberController = TextEditingController();
   //_nationalNumberController.text= UserGlobal.sudent.nationality_id!=null?UserGlobal.sudent.nationality_id:"";
    _passportController= TextEditingController();
   // _passportController.text= UserGlobal.sudent.nationality_id!=null?UserGlobal.sudent.nationality_id:"";
    UserGlobal.fbUser_name=UserGlobal.userName;
    // getMofas();
    print(UserGlobal.fbUser_name);
    fill_student_info();
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



  @override
  Widget build( context) {

    return new WillPopScope(
      /*   onWillPop: () async {
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
                flex:4,
                child: Padding(
                  padding: const EdgeInsets.only(top:10.0,bottom: 0),
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
              //  SizedBox(height: UserGlobal.screen_heigh/7),
//gridViewMofasWidget
              /*   Expanded(
                flex:6,
                child:  gridViewMofasWidget(mofasList),
              ),*/
              /*Expanded(
                flex:2,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(UserGlobal.branche.Icon),
                          fit: BoxFit.fill,
                        )),
                    child: Center(
                      child: Text(UserGlobal.branche.Name,
                        style: TextStyle(color: Colors.white,fontFamily: 'Hacen-Maghreb',fontSize: 14,fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),*/
              Expanded(
                flex:12,
                child:  Container(
                  color:Color(0xff0071BC).withOpacity(0.7),
                  child:ListView(
                    shrinkWrap: true,
                    primary: false,
                    //_iktController
                    //_emailController
                    //_phoneController
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          //  width: 100.0,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0,right: 15),
                            child: TextField(

                              controller: _iktController,
                              enabled: false,
                              decoration: InputDecoration(

                                border: const UnderlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,


                                labelText: UserGlobal.sudent.branch=="4"||UserGlobal.sudent.branch=="5"?"الرقم الامتحاني":'رقم الاكتتاب',
                                //  alignLabelWithHint: TextAlign.center
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,

                            ),
                          ),
                        ),
                      ),
                     /* Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          //  width: 100.0,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0,right: 15),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('المصدر'),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: DropdownButton<ListItem>(

                                          dropdownColor:Colors.white ,
                                          value: _selectedCity,
                                          items: __dropdownMenuCityItems,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedCity = value;

                                              //  helper.onLocaleChanged(new Locale(value.lang));
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          //  width: 100.0,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0,right: 15),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('الفرع'),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: DropdownButton<ListItem>(

                                          dropdownColor:Colors.white ,
                                          value: _selectedType,
                                          items: __dropdownMenuTypeItems,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedType = value;
                                              branch=value.ID;
                                              print(branch);
                                              //  helper.onLocaleChanged(new Locale(value.lang));
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ),
                      branch=="3"?   Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          //  width: 100.0,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0,right: 15),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('المهنة'),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: DropdownButton<ListItem>(

                                          dropdownColor:Colors.white ,
                                          value: _selectedCareer,
                                          items: __dropdownMenuCareerItems,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedCareer = value;

                                              //  helper.onLocaleChanged(new Locale(value.lang));
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ):SizedBox(),
                      branch=="2"?   Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          //  width: 100.0,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0,right: 15),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('النوع'),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: DropdownButton<ListItem>(

                                          dropdownColor:Colors.white ,
                                          value: _selectedLitrary,
                                          items: __dropdownMenuLitraryItems,
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedLitrary = value;

                                              //  helper.onLocaleChanged(new Locale(value.lang));
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ):SizedBox(),*/
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          //  width: 100.0,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0,right: 15),
                            child: TextField(

                              controller: _nationalNumberController,
                              decoration: InputDecoration(

                                border: const UnderlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,


                                labelText: 'الرقم الوطني',
                                //  alignLabelWithHint: TextAlign.center
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,

                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: SizedBox(
                            //  width: 100.0,
                              height: 20,
                              child:Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text('أو',style: TextStyle(color: Colors.white,fontSize: 15),),
                              ))),

                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SizedBox(
                          //  width: 100.0,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0,right: 15),
                            child: TextField(

                              controller: _passportController,
                              decoration: InputDecoration(

                                border: const UnderlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,


                                labelText: 'جواز السفر',
                                //  alignLabelWithHint: TextAlign.center
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,

                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child:SizedBox(
                          //  width: 100.0,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0,right: 15),
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
                      ),
                      Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: SizedBox(
                            //  width: 100.0,
                              height: 20,
                              child:Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text('يمكنك ترك هذا الحقل فارغا ليتم اعتماد رقم جوال حساب التطبيق',style: TextStyle(color: Colors.white,fontSize: 15),),
                              ))),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child:SizedBox(
                          //  width: 100.0,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15.0,right: 15),
                            child: TextField(
                              textDirection:TextDirection.ltr,
                              controller: _emailController,
                              decoration: InputDecoration(

                                border: const UnderlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,


                                labelText: 'البريد الالكتروني',
                              ),
                              keyboardType: TextInputType.emailAddress,

                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: SizedBox(
                            //  width: 100.0,
                              height: 20,
                              child:Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text('يمكنك ترك هذا الحقل فارغا ليتم اعتماد بريد حساب التطبيق',style: TextStyle(color: Colors.white,fontSize: 15),),
                              ))),

                    ],
                  ),
                ),
              ),
              Expanded(
                  flex:1,
                  child:FlatButton(
                    minWidth: 200.0,
                    // height: 100,
                    shape: RoundedRectangleBorder(

                        borderRadius:BorderRadius.circular(18.0),
                        side: BorderSide(color: Design_app().titleColor)
                    ),
                    color:  Design_app().barColor,
                    child:  Text('تعديل ',style: TextStyle(color: Design_app().titleColor,fontSize: 17)
                    ),
                    onPressed: () async{

        {
                        await update_student();
                        if (result == true) {
                          _showDialog_internet('تم التعديل', 'تم التعديل بنجاح');
                        }
                        else {
                          _showDialog_internet('خطأ', status);
                        }
                        result = false;
                      }
                    },
                  )

              ),
              /*  Expanded(
                  flex:3,
                  child:Bottom_List()

              )*/
            ],


          ),
        ),

      ),
    );
  }

  Future<void> showProgress(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(update_student(), message: Text('جاري التسجيل.....')),
    );


  }
  Future <bool>  update_student() async
  {
    String email=_emailController.text.isNotEmpty?_emailController.text:UserGlobal.userMail;
    String user_name=UserGlobal.userName;
    //String ikt=_iktController.text;
    // String branch=UserGlobal.branche.ID;
   // String city=_selectedCity.ID.toString();
    String branch_type="1";
    UserGlobal.sType=" ";
    if(branch=="2") {
      branch_type = _selectedLitrary.ID.toString();
      UserGlobal.sType=_selectedLitrary.ID;
    }
    else   if(branch=="3")
    {  branch_type=_selectedCareer.ID.toString();
    UserGlobal.career=branch_type;
    }



    String mobile=_phoneController.text.isNotEmpty?"9639"+_phoneController.text:UserGlobal.mobile;
    String passport=_passportController.text.isNotEmpty?_passportController.text:" ";
    String national_number=_nationalNumberController.text.isNotEmpty?_nationalNumberController.text:" ";

    Services ss= Services();
    result=await ss.update_student(email, user_name, UserGlobal.sudent.student_id, email,
          mobile, passport, national_number);

    status=ss.messsage;
    /*if(result==true)
    {
      UserGlobal.activation_type="1";
      // UserGlobal.userName=userName;
      _showDialog_ActivateCode('تفعيل الاشتراك',"تم إرسال كود التفعيل، الرجاء تفعيل الاشتراك.");
    }
    else
    { _showDialog_internet('خطأ',status);
    }*/
    return result;
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

