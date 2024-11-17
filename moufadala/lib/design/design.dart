import 'package:flutter/material.dart';
class Design_app
{
 // Color barColor =Colors.green;
  Color barColor;
  Color backgroundColor ;
  Color barColor_light ;
  Color text_BackgroundColor;
  Color componentColor;
  Color componentTextColor;
  Color titleColor;
  Color backgroundTitle;
  Color backgroundRating;
  Color backgroundTimeToReplay;
  // #638354
  Design_app(){
    //backgroundColor: Color(0xff7e2a9a),
//#7e2a9a
  //6f42c1
    //#6610f2
    //007bff

  //  barColor= _colorFromHex('#7e2a9a');
    //282461
    barColor= Color(0xff282461);

    barColor_light = Colors.blue[300];
   // barColor= Colors.blue;
   // barColor= Color.fromRGBO(70, 42, 120, 1);
    //backgroundRating= Color.fromRGBO(255, 255, 255, 0.7);

    //#b257d0
    //571f6a
    componentColor=Colors.white;
    componentTextColor= Colors.black;
    titleColor= Colors.white;
    backgroundColor=Colors.grey[100];
   // text_BackgroundColor=_colorFromHex('#172b4c');
    text_BackgroundColor=_colorFromHex('#172b4c');
    //backgroundTitle=_colorFromHex('#b257d0');
    backgroundRating= Colors.grey[200];
    backgroundTitle= Color(0xffb257d0);
    backgroundTimeToReplay= Color(0xff571f6a);

  }
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}