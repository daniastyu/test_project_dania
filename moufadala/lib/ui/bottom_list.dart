import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moufadala/global/userGlobal.dart';
import 'package:url_launcher/url_launcher.dart';

class Bottom_List extends StatefulWidget {
 // const GreenFrog({ Key? key }) : super(key: key);
  @override
  _Bottom_ListState createState() => _Bottom_ListState();
}

class _Bottom_ListState extends State<Bottom_List> {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        //forceSafariVC: false,
        //forceWebView: false,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      _showDialog_sendResult(
          'خطأ', 'الملف غير موجود', 0);
      throw 'Could not launch $url';
    }
  }

  _showDialog_sendResult(title, text, int status) {
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

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Colors.white.withOpacity(0.3),
        child:  GridView.count(
              shrinkWrap: true,
              primary: true,
              crossAxisCount:3 ,

             // scrollDirection: Axis.vertical,
             // physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing:1,
              // childAspectRatio: 2,
              children:     UserGlobal.linkInfoList.map((value) {
                int index=    UserGlobal.linkInfoList.indexOf(value);
                //print(index);

                return InkWell(
                            child: Container(
                               // padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [

                                    Container(
                                      padding: const EdgeInsets.only(bottom:0.0),
                                      child: IconButton(
                                        /* icon: Icon(
                                                      Icons.share,
                                                    ),*/
                                        //  icon:FaIcon(FontAwesomeIcons.share),
                                        icon:Image.asset(value.icon, width: double.infinity),
                                        iconSize:100,
                                        color: Colors.blueAccent,
                                        splashColor: Colors.blue,

                                        onPressed: () {
                                          //  share(context, value.url);
                                          _launchInBrowser(value.url);

                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            onTap: () {

                             print(value.url);
                               _launchInBrowser(value.url);
                            },
                          );
              }).toList(),


            ),


      /* CarouselSlider(

                      items:  UserGlobal.slider_list.map((item) => Container(
                        child: InkWell(
                          child: Container(
                              width: double.infinity,
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                child: Stack(
                                  children: <Widget>[
                                    //  Image.asset(item, fit: BoxFit.fill, width: double.infinity),
                                    Image.network(item, fit: BoxFit.contain, width: 100),
                                    /*  Container(
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage(item),
                            fit: BoxFit.fill,

                          )),
                      child: Text(' ')),*/
                                    Positioned(
                                      bottom: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(200, 0, 0, 0),
                                              Color.fromARGB(0, 0, 0, 0)
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                        child: Text(
                                         ' item.subject',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                          onTap: () {

                           // _showDialog_imagedetails(item.subject,item.photo);

                          },
                        ),
                      )).toList(),

                      options: CarouselOptions(
                       // height: 400,
                        aspectRatio: 2.0,
                        viewportFraction: 0.4,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        pageSnapping: false,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,


                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,

                      )

                ),*/
    );
  }
}