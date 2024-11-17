import 'dart:math' as math;


import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:moufadala/api/serviceClass.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:moufadala/api/services.dart';

import 'package:moufadala/ui/home.dart';


import 'package:moufadala/ui/sideMenu.dart';
import 'package:moufadala/ui/web_Page.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moufadala/design/design.dart';
import 'package:moufadala/ui/loginPage.dart';

import 'package:future_progress_dialog/future_progress_dialog.dart';
class NotificationPage extends StatefulWidget {
  static const String ROUTE_ID = 'NotificationArchivePage';
  @override
  _NotificationArchivePageState createState() => _NotificationArchivePageState();
}

class _NotificationArchivePageState extends State<NotificationPage> {
  final _formKey = GlobalKey<FormState>();

//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int pager = 0;
  Design_app design = new Design_app();
  String userLoginName = 'C';
  bool load_data = false;
  String fb_token = '';
  String status = '';

  //#7e2a9a
  Color barColor = Colors.black;
  Color backgroundColor = Colors.green;
  Color text_Color = Colors.black;
  Color text_BackgroundColor = Colors.green;

  @override
  bool get wantKeepAlive => true;

  static const maxCount = 20;
  final random = math.Random();
  final scrollDirection = Axis.vertical;
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);


  AutoScrollController controller;


  //List<List<int>> randomList;


  List<NotificationArchive> NewsClassList = new List<NotificationArchive>();
  ScrollController _scrollController = new ScrollController();

  Future<List<NotificationArchive>> getNewsClassList() async
  {
    List<NotificationArchive> temp = await Services()
        .getAlnashra_notifications(pager);
    for (int i = 0; i < temp.length; i++) {
      NewsClassList.add(temp[i]);

      load_data = true;

      setState(() {

      });
    }
  }
    @override
    void initState() {
      barColor = design.barColor;
      super.initState();

      controller = AutoScrollController(
          viewportBoundaryGetter: () =>
              Rect.fromLTRB(0, 0, 0, MediaQuery
                  .of(context)
                  .padding
                  .bottom),
          axis: scrollDirection);
      //getNews();
      getNewsClassList();
    }


    int counter = -1;
    Future _scrollToIndex() async {
      setState(() {
        counter += 12;

        if (counter >= maxCount) counter = 0;
      });

      await controller.scrollToIndex(counter,
          preferPosition: AutoScrollPosition.begin);
      controller.highlight(counter);
    }


    Widget _wrapScrollTag({ int index, Widget child}) =>
        AutoScrollTag(
          key: ValueKey(index),
          controller: controller,
          index: index,
          child: child,
          highlightColor: Colors.black.withOpacity(0.1),
        );


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


    void showResultDialog(BuildContext context, String result) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              content: Text(result),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                )
              ],
            ),
      );
    }

  Future<void> showProgress(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(getFuture(), message: Text('جاري التحميل....')),
    );
    //showResultDialog(context, result);
  }
  Future getFuture() {
    return Future(() async {
      //await Future.delayed(Duration(seconds: 5));
      await getNewsClassList();
      return 'Hello, Future Progress Dialog!';
    });
  }
    // await getNewsClassList();

    Widget listViewWidget(List<NotificationArchive> notList) {
      if (notList.length == 0) {
        return Container(
            height: 100,
            width: double.infinity,
            color: Colors.grey[100],
            child: Center(child: Text('لا توجد إشعارات ')));
      }
      else
        //print('-----------------${notList.length}');
        return AnimationLimiter(
          //color: Colors.grey[100],
          child: ListView.builder(
              itemCount: notList.length,
              controller: _scrollController,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1000),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: ScaleAnimation(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.grey[100],
                        child: ListTile(
                          title: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 1.0, right: 5),
                                child:
                                Text(

                                  notList[index].subject != null
                                      ? notList[index].subject
                                      : ''
                                  ,

                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),


                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 1.0, right: 5),
                                child:
                                Text(
                                  notList[index].message.toString()
                                  ,

                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),


                              ),


                            ],
                          ),

                          onTap: () {
                            //  _showDialog_idetails(' ',notList[index]);
                            /* UserGlobal.newsDetails=notList[index];
                       Navigator.pushNamed(
                           context,
                           NewsDetailsPage.ROUTE_ID);*/
                            if (notList[index].url != null) {
                              UserGlobal.url_type = '1';
                              // print(notList[index].url);
                              UserGlobal.new_url = notList[index].url;
                              Navigator.pushNamed(
                                  context,
                                  Web_Page.ROUTE_ID);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
    }

    @override
    Widget build(context) {
      print(UserGlobal.userToken);
      final orientation = MediaQuery
          .of(context)
          .orientation;
      int x = (orientation == Orientation.portrait) ? 2 : 5;
      int header_fix = (orientation == Orientation.portrait) ? 1 : 2;
      int body_fix = (orientation == Orientation.portrait) ? 8 : 7;
      double font_size = (orientation == Orientation.portrait) ? 12 : 15;
      // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      //barColor = _colorFromHex('#0e4b46');
      return Scaffold(
        drawer: SideMenu(),
        backgroundColor: barColor,
        key: _scaffoldMainstate,


        body: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              )),
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [

                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.grey,
                        size: 35,
                      ),
                      // onPressed: () => _scaffoldMainstate.currentState.openEndDrawer(),
                      onPressed: () =>
                          _scaffoldMainstate.currentState.openDrawer(),
                    ),


                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        child: Container(
                          width: 80,
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
                        onTap: () {
                          Navigator.pushNamed(context, Homepage.ROUTE_ID);
                        },
                      ),
                    )

                  ],
                ),
              ),

              //SizedBox(height: 10,),

              SizedBox(height: 20,),


              Expanded(child: load_data ? Container(

                  child: listViewWidget(NewsClassList))
                  : Center(child: CircularProgressIndicator())),

              /* Expanded(
              child: FutureBuilder(
                  future:  getNewsClassList() ,
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? listViewWidget(snapshot.data)
                        : Center(child: CircularProgressIndicator());
                  }),
            ),*/
              //  ScrollingPage(),
              /* Expanded(
              child: ListView(
                scrollDirection: scrollDirection,
                controller: controller,
                children: randomList.map<Widget>((data) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: _getRow(int.parse(data[0].id), data[0]),
                  );
                }).toList(),
              ),
            ),
           FloatingActionButton(
              onPressed: _scrollToIndex,
              tooltip: 'Increment',
              child: Text(counter.toString()),
            ),*/
              FlatButton(
                minWidth: 250.0,
                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: design.titleColor)
                ),

                color: design.barColor,
                child: Text('رؤية المزيد',
                    style: TextStyle(color: design.titleColor, fontSize: 18)
                ),
                onPressed: () async {
                  pager++;
                  load_data = false;
/*setState(() {

});*/
                 await showProgress(context);

                  double a = double.parse(NewsClassList.length.toString());
                  _scrollController.jumpTo(
                      _scrollController.position.maxScrollExtent);
                },
              ),


            ],


          ),
        ),
      );
    }


  }



class ScrollingPage extends StatefulWidget {

  @override
  _ScrollingPageState createState() => _ScrollingPageState();
}

class _ScrollingPageState extends State<ScrollingPage> {
  static const maxCount = 100;
  final random = math.Random();
  final scrollDirection = Axis.vertical;

  AutoScrollController controller;
  List<List<int>> randomList;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    randomList = List.generate(maxCount,
            (index) => <int>[index, (1000 * random.nextDouble()).toInt()]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          scrollDirection: scrollDirection,
          controller: controller,
          children: randomList.map<Widget>((data) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: _getRow(data[0], math.max(data[1].toDouble(), 50.0)),
            );
          }).toList(),


        ),

        FloatingActionButton(
          onPressed: _scrollToIndex,
          tooltip: 'Increment',
          child: Text(counter.toString()),
        ),
      ],
    );
  }

  int counter = -1;
  Future _scrollToIndex() async {
    setState(() {
      counter++;

      if (counter >= maxCount) counter = 0;
    });

    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(counter);
  }

  Widget _getRow(int index, double height) {
    return _wrapScrollTag(
        index: index,
        child: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.topCenter,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlue, width: 4),
              borderRadius: BorderRadius.circular(12)),
          child: Text('index: $index, height: $height'),
        ));
  }

  Widget _wrapScrollTag({ int index,  Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );
}