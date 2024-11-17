import 'package:moufadala/global/userGlobal.dart';

import 'package:moufadala/ui/sideMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/ui/home.dart';
import 'package:moufadala/api/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:moufadala/ui/registerPage.dart';

class Web_Page extends StatefulWidget {
  // SignupPage( {Key key, this.title}) : super(key: key);
  static const String ROUTE_ID = 'Web_Page';
  //final String title;

  @override
  _MapPageState createState() => _MapPageState();
}
String emptyuser='';
class _MapPageState extends State<Web_Page> {
  Future<SharedPreferences> prefs =   SharedPreferences.getInstance() ;



  String page_url= 'UserGlobal.serach_Url'+"&email="+UserGlobal.userName.toString()+"&token="+UserGlobal.userToken.toString();


  double progress = 0;
  bool isLoading=true;
  final _key = UniqueKey();
  InAppWebViewController webView;
  String _email='';
  int visible = 0;
  String _password='';
  Design_app design_app=Design_app();
  Color barColor =Colors.green;


  @override
  void initState() {
    page_url=UserGlobal.new_url;
    if( UserGlobal.url_type=='1')
      {
        page_url=UserGlobal.new_url;
      }
    else if( UserGlobal.url_type=='2')//official search
    {
     // page_url="https://media.sy/api/arabic/eindex.php?node=3433";
      page_url="http://elan.gov.sy/2017/site/arabic/index.php?node=3433&AppId=2";
    }
    else if( UserGlobal.url_type=='3')//official search
        {
      //page_url="https://media.sy/api/arabic/eindex.php?node=3434&UID="+UserGlobal.fbToken;
     // page_url= "https://media.sy/api/arabic/eindex.php?node=3434&UID=93be334963c666a90c40e3322620bfef";
      page_url="http://elan.gov.sy/2017/site/arabic/index.php?node=3434&AppId=2&user_name="+UserGlobal.userName;
      print('fb_token:'+UserGlobal.userName);
    }
   // page_url=page_url+"lat1="+MyCardenates.lat1+"&lon1="+MyCardenates.lon1+"&lat2="+MyCardenates.lat2+"&lon2="+MyCardenates.lon2;

    page_url=UserGlobal.new_url;
    print('page_url---------------------------');
    print(page_url);
   /* SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);*/
    super.initState();
    // controller  = new ChessBoardController();


  }

  @override
  dispose(){
   /* SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);*/
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _scaffoldMainstate =
  new GlobalKey<ScaffoldState>();
  setStatus(String message) {
    setState(() {
      // status = message;
    });
  }
  share(BuildContext context, String alligator) {
    final RenderBox box = context.findRenderObject();

    Share.share("${alligator} - ${alligator}",
        subject: alligator,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
  @override
  Widget build(BuildContext context) {
    _checkInternetConnectivity();
    return new Scaffold(
        backgroundColor: design_app.backgroundColor,
        drawer: SideMenu(),

        key: _scaffoldMainstate,
        body:  Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              )),
         // constraints: BoxConstraints.expand(),

          // color: design_app.backgroundColor,
          //   color:_design.backgroundColor,
          child: Container(
          //  color: Colors.black.withOpacity(UserGlobal.brightness_value),
            //padding: const EdgeInsets.fromLTRB(16.0,0,16.0,0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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

            /*    IconButton(
                    icon: Icon(
                      Icons.share,
                    ),
                    iconSize: 20,
                    color: Colors.green,
                    splashColor: Colors.purple,
                    onPressed: () => share(context, 'sdfdsf')

                  /* onPressed: () {
                                    share(context, notList[index]);
                                  },*/
                ),*/
                Expanded(
                  flex: 8,

                  //.-320.flex:8,
                  child: WillPopScope(
                    onWillPop: () async {

                     // webView.clearCache();
                      return true;
                    },
                    child: Stack(
                      children: <Widget>[


                        Container(
                          // margin: const EdgeInsets.all(10.0),
                          child: Stack(
                            children: <Widget>[
                              InAppWebView(
                               // initialFile: page_url,
                                initialUrlRequest:
                                URLRequest(url: Uri.parse(page_url)),
                                //   initialUrl: "assets/index.html?client=" + (Platform.isAndroid ? 'android': 'ios'),


                                initialOptions: InAppWebViewGroupOptions(
                                  crossPlatform: InAppWebViewOptions(

                                    useShouldOverrideUrlLoading: true,
                                    supportZoom: true,

                                    // builtInZoomControls:false
                                  ),


                                ),



                                onLoadStop: (controller, url) async {

                                  setState(() {
                                   isLoading=false;
                                  });
                                },
                                onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {




                                },



                              ),


                            ],

                          ),
                        ),


                        isLoading ? Center( child: CircularProgressIndicator(),)
                            : Stack(),
                      ],

                    ),
                  ),
                )




              ],
            ),
          ),
        ));
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
  addUserToSF(int id, String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('UserName', name);
    prefs.setInt('UserId',id);

  }


}


