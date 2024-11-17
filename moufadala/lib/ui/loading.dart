

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moufadala/UI/home.dart';
import 'package:moufadala/api/serviceClass.dart';
import 'package:moufadala/api/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:moufadala/ui/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  Loading() : super();

  static const String ROUTE_ID = 'Loading';
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time="Loading......";
  String user_name = '-C';
  Design_app design=new Design_app();
  Future<void>   setUpWorldTIme()
  async {
    //WorldTime instance =WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png');
    // print('date:-----------------------------------');
    await  Future.delayed(Duration(seconds: 1));
    setState(() {

    });
    //print(instance.time);
    Navigator.pushNamed(context, Homepage.ROUTE_ID);
  }


  getUserFromSF() async {

    try {
      UserGlobal.activation_type="0";
      UserGlobal.careerslist= await Services().getCareersList();
      UserGlobal.citieslist= await Services().getCityList();
      List<Branches> branches= await Services().getBranchesList();
      UserGlobal.hs_types_list= await Services().get_Hs_types();
    //  UserGlobal.hs_types_list= await Services().get_Hs_types();
      UserGlobal.hs_sub_branches_list= await Services().get_hs_sub_branches_List();
      UserGlobal.hs_acceptance_list= await Services().get_hs_acceptance_List();


      for(int i=0; i<branches.length;i++)
        {
          UserGlobal.brancheslist.add(ListItem(ID:branches[i].ID,Name:branches[i].Name));
        }
     //
      FirebaseMessaging.instance.subscribeToTopic("allDevices");
      SharedPreferences prefs = await SharedPreferences.getInstance();

      UserGlobal.userMail = prefs.getString('Useremail') ?? null;
      UserGlobal.userName = prefs.getString('UserName') ?? null;

      UserGlobal.userToken = prefs.getString('usertoken') ?? null;
      UserGlobal.fbUser_name = prefs.getString('fbUser_name') ?? null;
      UserGlobal.profile_email = prefs.getString('EMail') ?? null;
      UserGlobal.uid = prefs.getString('UID') ?? null;
      UserGlobal.voiceType = prefs.getString('voiceType') ?? null;
      UserGlobal.activeAccount = prefs.getString('activeAccount') ?? null;

      UserGlobal.FName = prefs.getString('FName') ?? null;
      UserGlobal.LName = prefs.getString('LName') ?? null;
      UserGlobal.mobile = prefs.getString('mobile') ?? null;
      UserGlobal.sex = prefs.getString('sex') ?? null;
if( UserGlobal.userMail==null)
  Navigator.pushNamed(context, LoginPage.ROUTE_ID);
else
      Navigator.pushNamed(context, Homepage.ROUTE_ID);
      //  prefs.getString('voiceType', voiceType);

    }
    catch(e)
    {}




  }


  @override
  void initState() {
    get_site_info();
    super.initState();

    getUserFromSF();


  }

  void get_site_info() async
  {
    UserGlobal.links=await Services().getlinksList();
    LinkInfo facebook=new LinkInfo(name: "facebook",url:UserGlobal.links.facebook,icon:"assets/fb.png" );
   // print(UserGlobal.links.facebook);
    UserGlobal.linkInfoList.add(facebook);
    LinkInfo ministry=new LinkInfo(name: "Ministry",url:UserGlobal.links.ministry,icon:"assets/web 1.png" );
    UserGlobal.linkInfoList.add(ministry);
    LinkInfo mofa=new LinkInfo(name: "mofa",url:UserGlobal.links.mofa,icon:"assets/web 2.png" );
    UserGlobal.linkInfoList.add(mofa);
    /*LinkInfo phone=new LinkInfo(name: "phone",url:UserGlobal.links.phone,icon:"assets/web 2.png" );
    UserGlobal.linkInfoList.add(phone);
    LinkInfo email=new LinkInfo(name: "email",url:UserGlobal.links.email,icon:"assets/web 2.png" );
    UserGlobal.linkInfoList.add(phone);*/



  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            )),
        child: Center(
          //SpinKitRotatingCircle
          child:   SpinKitFadingCircle(
            //  color: Colors.white,
            color: design.barColor,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
