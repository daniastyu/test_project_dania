import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moufadala/api/serviceClass.dart';
import 'package:moufadala/api/user_info.dart';
import 'package:moufadala/global/userGlobal.dart';

import 'package:shared_preferences/shared_preferences.dart';




class Services{



  String url= App_info.site_url;
 // String url= 'https://e-gate.me/aao/media/dev/api/services.php';
  //e-gate.me
  int timeout=200;

  String result="false";
  String userToken = '';
  String confirm_code='';
  int confirm_result=0;
  String fbtoken='';
  String userName='';
  String uid='';
  int lang=0;
  String messsage='';


  addUserToSF(String utoken, String name,String uid,String mail,String fbUser_name,String activeAccount, String  EMail,
      String FName, String LName, String sex, String mobile
  ) async {
    final prefs = await SharedPreferences.getInstance();
  //  print('+++++++++++$name');
    prefs.setString('UID', uid);
    prefs.setString('UserName', name);

    prefs.setString('Useremail', mail);
    prefs.setString('activeAccount', activeAccount);
    prefs.setString('usertoken',utoken);
    prefs.setString('fbUser_name',fbUser_name);
    prefs.setString('EMail',EMail);

    prefs.setString('FName', FName);
    prefs.setString('LName',LName);
    prefs.setString('sex',sex);
    prefs.setString('mobile',mobile);
  }
  String getResult()
  {
    return result;
  }




  getUserfbtokenFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    fbtoken = prefs.getString('fbtoken') ?? '-2';
  }

  Future< List<NotificationArchive> > checkMofadala_notifications(int page) async{


    List<NotificationArchive> list1= new  List<NotificationArchive> ();
    try{
      var response = await http.post(Uri.parse(url), body:
      {'service':'check_my_notifications',
        'user_name':UserGlobal.userMail.toString(),
        'token':UserGlobal.userToken.toString(),
        // 'UID':UserGlobal.fbToken.toString(),
        //  'UID':'93be334963c666a90c40e3322620bfef',
        'page':page.toString(),

      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);

      print('-----------media check_notifications_fbToken- ${UserGlobal.fbToken.toString()}-----------------------');
      // print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          //  print(rest);
          for (final name in rest.keys)
          {
            print(rest[name].toString());

            NotificationArchive a= NotificationArchive.fromJson(rest[name]);
            print(rest[name]);
            // print( a.case_id);
            list1.add(a);
          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }

  Future< List<Gen_news> > gen_news() async{
    //print(UserGlobal.userMail);
    List<Gen_news> list1= new  List<Gen_news> ();
    try{
      var response = await http.post(Uri.parse(url), body:
      {'service':'gen_news',
        'email':UserGlobal.userMail.toString(),
        'token':UserGlobal.userToken.toString(),
      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
      //  print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          //  print(rest);
          for (final name in rest.keys)
          {
            //  print('-------------------------------------------------------');
            //print(rest[name]);

            Gen_news a= Gen_news.fromJson(rest[name]);
            // print( a.case_id);
            if( a.subject!=null) {
              //  print(a.subject);
              list1.add(a);
              // list.add(a);
            }
          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }

  Future< List<NotificationArchive> > getAlnashra_notifications(int page) async{


    List<NotificationArchive> list1= new  List<NotificationArchive> ();
    try{
      var response = await http.post(Uri.parse(url), body:
      {'service':'my_notifications',
        'user_name':UserGlobal.userName.toString(),
        'token':UserGlobal.userToken.toString(),
        // 'UID':UserGlobal.fbToken.toString(),
        //  'UID':'93be334963c666a90c40e3322620bfef',
        'page':page.toString(),

      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);

      print('-----------Alnashra_notifications_fbToken- ${UserGlobal.fbToken.toString()}-----------------------');
      //print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          //  print(rest);
          for (final name in rest.keys)
          {
            print(rest[name].toString());

            NotificationArchive a= NotificationArchive.fromJson(rest[name]);
            // print( a.case_id);

              // print(a.title);
              list1.add(a);
              // list.add(a);

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }

  Future< List<Branches> > getBranchesList() async{
    List<Branches> list1= new  List<Branches> ();
    print(url);
    try{
     // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'branches'}
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
     // print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          for (final name in rest.keys)
          {
            //print(data["info"][name]);
            Branches a= Branches.fromJson(rest[name]);
            List<String> typeList= new  List<String>();
            if(rest[name]['Types']!=null)
              {

                for (final type in rest[name]['Types'].keys) {
                  typeList.add(rest[name]['Types'][type].toString());
               //  print(rest[name]['Types'][type]);
                }
              }
            a.Types=typeList;
            list1.add(a);

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }


  Future< List<Student> > getStudentsList() async{
    List<Student> list1= new  List<Student> ();
  //  print(url);
    try{
      String url1=url+"?service=list_students&email="+UserGlobal.userName+"&token="+UserGlobal.userToken;
      print(url1);
      var response = await http.post(Uri.parse(url), body:
      {'service':'list_students',
        'email':UserGlobal.userName,
        'token':UserGlobal.userToken}
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
       print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          for (final name in rest)
          {
            //print(data["info"][name]);
            Student a= Student.fromJson(name);
       print(a.name);
            list1.add(a);

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }



  Future< List<Mofas> > getMofasList(String branch) async{
    List<Mofas> list1= new  List<Mofas> ();
   // print(url);
    try{
      // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'mofas',
      'branch':branch}
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
     // print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"]["List"] ;
          UserGlobal.mType=data["info"]["ID"];
          //print(data["info"]["ID"]);
          for (final name in rest)
          {
            print(name);
            try {
              if(name!=null)
             { Mofas a = Mofas.fromJson(name);
                //print(a.MofaName);
              list1.add(a);
             }
            }
            catch(e)
    {}

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }
  Future< List<ListItem> > getCareersList() async{
    List<ListItem> list1= new  List<ListItem> ();
    // print(url);
    try{
      // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'careers',
       }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
      print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          for (final name in rest)
          {
           // print(name);
            //print(data["info"][name]);
            try {
              if(name!=null)
              { ListItem a = ListItem.fromJson(name);
              //print(a.Name);
              //print(a.MofaName);
              list1.add(a);}
            }
            catch(e)
            {}

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }


  Future< List<ListItem> > get_hs_cycles_List(String type) async{
    List<ListItem> list1= new  List<ListItem> ();
    // print(url);
    try{
      // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'hs_cycles',
        'type':type,
      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
      print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          for (final name in rest)
          {
            // print(name);
            //print(data["info"][name]);
            try {
              if(name!=null)
              { ListItem a = ListItem.fromJson(name);
              //print(a.Name);
              //print(a.MofaName);
              list1.add(a);}
            }
            catch(e)
            {}

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }

  Future< List<ListItem> > get_hs_sub_branches_List() async{
    List<ListItem> list1= new  List<ListItem> ();
    // print(url);
    try{
      // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'hs_sub_branches',

      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
      print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          for (final name in rest)
          {
            // print(name);
            //print(data["info"][name]);
            try {
              if(name!=null)
              { ListItem a = ListItem.fromJson(name);
              //print(a.Name);
              //print(a.MofaName);
              list1.add(a);}
            }
            catch(e)
            {}

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }

  Future< List<ListItem> > get_hs_acceptance_List() async{
    List<ListItem> list1= new  List<ListItem> ();
    // print(url);
    try{
      // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'hs_acceptance',

      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
      print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          for (final name in rest)
          {
            // print(name);
            //print(data["info"][name]);
            try {
              if(name!=null)
              { ListItem a = ListItem.fromJson(name);
              //print(a.Name);
              //print(a.MofaName);
              list1.add(a);}
            }
            catch(e)
            {}

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }


  Future< List<Hs_types> > get_Hs_types() async{
    List<Hs_types> list1= new  List<Hs_types> ();
    // print(url);
    try{
      // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'hs_types',
      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
      //print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          for (final name in rest)
          {
            try {
              if(name!=null)
              { Hs_types a = Hs_types.fromJson(name);
              print(a.Name);
              if(name["Special"]!=null&&name["Special"]!="")
                {
                  List<ListItem> special_list1= new  List<ListItem> ();
                  for (final key in name["Special"].keys)
                    {
                      print(key);
                      print(name["Special"][key]);
                      ListItem special=new ListItem(ID:key.toString(),Name: name["Special"][key]);
                      special_list1.add(special);
                    }
                  a.special_list=special_list1;
                }

              list1.add(a);

              }
            }
            catch(e)
            {
              print('exception:'+e.toString());
            }

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }


  Future< List<ListItem> > getCityList() async{
    List<ListItem> list1= new  List<ListItem> ();
    // print(url);
    try{
      // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'cities',
      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
      //print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          for (final name in rest)
          {
           // print(name);
            //print(data["info"][name]);
            try {
              if(name!=null)
              { ListItem a = ListItem.fromJson(name);
             // print(a.Name);
              //print(a.MofaName);
              list1.add(a);}
            }
            catch(e)
            {}

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }

  Future< List<Bill> > get_list_invoices() async{
    List<Bill> list1= new  List<Bill> ();
    // print(url);
    try{
      // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'list_invoices',
        'email':UserGlobal.userName.toString(),
        'token':UserGlobal.userToken.toString(),
        'ikt' :UserGlobal.sudent.ikt,
        'branch' :UserGlobal.sudent.branch,
        // 'UID':UserGlobal.fbToken.toString(),
        //  'UID':'93be334963c666a90c40e3322620bfef',
        'student_id':UserGlobal.student_id,
      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
      //print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {
          var rest = data["info"] ;
          for (final name in rest)
          {
            // print(name);
            //print(data["info"][name]);
            try {

              { Bill a = Bill.fromJson(name);
              // print(a.Name);
              //print(a.MofaName);
              list1.add(a);}
            }
            catch(e)
            {}

          }
        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }

  Future< Links > getlinksList() async{
    Links list1= new  Links ();
    print(url);
    try{
      // url="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=branches";
      var response = await http.post(Uri.parse(url), body:
      {'service':'links'}
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {

          Links a= Links.fromJson(data["info"]);
          list1=a;

        }
        else
        {
          //addUserToSF('-1','-2');
          result="Could n't connect to the server!";
        }
      }
      else
      {
        result="Could n't connect to the server!";
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
    }
    return list1;
  }

  Future<bool> logIn( String userName,String password, String fbtoken) async{
    try{
    //  http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service= login&email=MU963944233037&password=123456

print(fbtoken);
      var response = await http.post(Uri.parse(url), body:
      {'service':'login','email' : userName.toString(),

        'password' : password.toString(),
        'fbtoken':fbtoken.toString()}).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
 if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          Map dataInfo = data['info'];
          //print('Response status: ${dataInfo}');
          UserGlobal.ActiveAccount = dataInfo['ActiveAccount'].toString();
          if(dataInfo['ActiveAccount'].toString()=="1") {
            String id = dataInfo['ID'].toString();
            // print('Response status: $id}');
            UserGlobal.FName = dataInfo['FName'].toString();
            UserGlobal.LName =  dataInfo['LName'].toString();
            String token = dataInfo['TOKEN'].toString();
            //ActiveAccount
            UserGlobal.activeAccount = dataInfo['ActiveAccount'].toString();
            //ActiveAccount
            UserGlobal.profile_email=dataInfo['EMail'].toString();
            UserGlobal.mobile=dataInfo['Mobile'].toString();
            print('mobile: ${ UserGlobal.mobile}');
            userName=dataInfo['UserName'].toString();
            UserGlobal.sex=dataInfo['Sex'].toString();
            print('Response status: $userName}');
            String fbUser_name = userName;
            UserGlobal.userMail = userName;

            // UserGlobal.fbUser_name=userName;

            //  UserGlobal.name=un;
            this.result = 'true';
            UserGlobal.userName = userName;
            UserGlobal.userToken = token;
            UserGlobal.uid = id;

            addUserToSF(token, userName, id, userName, fbUser_name, UserGlobal.activeAccount, UserGlobal.profile_email ,
                UserGlobal.FName, UserGlobal.LName, UserGlobal.sex, UserGlobal.mobile);

            return true;
          }
          else return true;

        }

        else
        {
            this.result='اسم المستخدم أو كلمة المرور غير صحيحة';
         return false;
        }
      }
      else
      {
        // addUserToSF('-2','-2','-2');
       return false;
      }
    }
    catch(e)
    {
      this.result=e.toString();
     return false;

    }
  }


  Future<bool> delete_student( String student_id,String ikt,String branch) async{
    try{
print(student_id);
    // http://localhost/mofa_api/services.php?service=remove_student&
      // user_name=MU963944233037&student_id=2120111208&token=cb242fff47cb82d6c692f45cd296dce3
      var response = await http.post(Uri.parse(url), body:
      {'service':'remove_student','user_name' : UserGlobal.userName,
        'token' : UserGlobal.userToken,
        'student_id' : student_id,
        'ikt' : ikt,
        'branch' : branch,
      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          Map dataInfo = data['info'];

          //print('Response status: ${dataInfo}');


          return true;

        }

        else
        {
          this.result='اسم المستخدم أو كلمة المرور غير صحيحة';
          return false;
        }
      }
      else
      {
        // addUserToSF('-2','-2','-2');
        return false;
      }
    }
    catch(e)
    {
      this.result=e.toString();
      return false;

    }
  }

//https://media.sy/services.php?service=activate&email=bassel&code=230189&fbtoken=fsafafas
  Future<bool> activate( String userName,String code,String fbtoken) async{
    try{
      // String url1='http://thebestinsyria.net/media/dev/site/services.php?service=login&email=smandarb@gmail.com&password=984088717';
      //  var response = await http.post(url1).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
print('$url-----------------');
print('email:$userName');
print('code:$code');
      var response = await http.post(Uri.parse(url), body:
      {'service':'activate','email' : userName,
        'code' : code,
        //'fbtoken':fbtoken
      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          Map dataInfo = data['info'];

          //print('Response status: ${dataInfo}');

            String id = dataInfo['ID'].toString();
            // print('Response status: $id}');
            UserGlobal.FName = dataInfo['FName'].toString();
            UserGlobal.LName =  dataInfo['LName'].toString();
            String token = dataInfo['TOKEN'].toString();
            //ActiveAccount
            UserGlobal.activeAccount = dataInfo['ActiveAccount'].toString();
            //ActiveAccount
            UserGlobal.profile_email=dataInfo['EMail'].toString();
            UserGlobal.mobile=dataInfo['Mobile'].toString();
            UserGlobal.sex=dataInfo['Sex'].toString();
          userName=dataInfo['UserName'].toString();
            print('Response status: $userName}');
            String fbUser_name = userName;
            UserGlobal.userMail = userName;

            // UserGlobal.fbUser_name=userName;

            //  UserGlobal.name=un;
            this.result = 'true';
            UserGlobal.userName = userName;
            UserGlobal.userToken = token;
            UserGlobal.uid = id;

            addUserToSF(token, userName, id, userName, fbUser_name, UserGlobal.activeAccount, UserGlobal.profile_email ,
                UserGlobal.FName, UserGlobal.LName, UserGlobal.sex, UserGlobal.mobile);




          // UserGlobal.fbUser_name=userName;

          //  UserGlobal.name=un;
          this.result='true';


          return true;

        }

        else
        {
          this.result='اسم المستخدم أو كلمة المرور غير صحيحة';
          return false;
        }
      }
      else
      {
        // addUserToSF('-2','-2','-2');
        return false;
      }
    }
    catch(e)
    {
      this.result=e.toString();
      return false;

    }
  }

  Future<bool> activate_student( String userName,String code) async{
    try{
      http://localhost/mofa_api/services.php?service=activate_student&code=485442&
      // user_name=MU963944233037&student_id=2120111208&token=cb242fff47cb82d6c692f45cd296dce3
        print('------$userName----$code-----------------');
      print(UserGlobal.student_id);
      print(UserGlobal.sudent.ikt);
      print(UserGlobal.sudent.branch);
      var response = await http.post(Uri.parse(url), body:
      {'service':'activate_student','user_name' : userName,
        'code' : code,'student_id':UserGlobal.student_id,
        'ikt' :UserGlobal.sudent.ikt!=null?UserGlobal.sudent.ikt: UserGlobal.ikt,
       // 'ikt' :UserGlobal.sudent.ikt,
        'branch' :UserGlobal.sudent.branch,
        'token':UserGlobal.userToken
      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          Map dataInfo = data['info'];

          //print('Response status: ${dataInfo}');



          // UserGlobal.fbUser_name=userName;

          //  UserGlobal.name=un;
          this.result='true';


          return true;

        }

        else
        {
          this.result='اسم المستخدم أو كلمة المرور غير صحيحة';
          return false;
        }
      }
      else
      {
        // addUserToSF('-2','-2','-2');
        return false;
      }
    }
    catch(e)
    {
      this.result=e.toString();
      return false;

    }
  }


  Future<bool> resend_code( String userName) async{
    try{
      // String url1='http://thebestinsyria.net/media/dev/site/services.php?service=login&email=smandarb@gmail.com&password=984088717';
      //  var response = await http.post(url1).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));

      var response = await http.post(Uri.parse(url), body:
      {'service':'resend_code','email' : userName,
        'ikt' :UserGlobal.sudent.ikt,
        'branch' :UserGlobal.sudent.branch,

      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {

          return true;

        }

        else
        {
          this.result='اسم المستخدم أو كلمة المرور غير صحيحة';
          return false;
        }
      }
      else
      {
        // addUserToSF('-2','-2','-2');
        return false;
      }
    }
    catch(e)
    {
      this.result=e.toString();
      return false;

    }
  }
//http://e-gate.dtt.com.qa:8080/mofa_api/services.php?
// service=register_student&user_name=MU963944233037&ikt=11208&city=1&branch=2&branch_type=2&
// passport=222&national_number=5555&mobile=963954477775&token=cb242fff47cb82d6c692f45cd296dce3

  Future<bool> register_student( String email,String user_name,String city,String ikt,String branch,String branch_type,
      String mobile,String passport,String national_number) async{
    try{


      String url1="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=register_student&user_name="+user_name+"&ikt="+ikt;
      url1+="&city="+city+"&branch="+branch+"&branch_type="+branch_type+"&passport="+passport+"&diff_type="+UserGlobal.diff_type;
      url1+="&m_type="+UserGlobal.m_type+"&cycle="+UserGlobal.cycle.toString()+"&email="+email.toString();
      url1+="&national_number="+national_number+"&year="+UserGlobal.year.toString()+"&mobile="+mobile+"&token="+UserGlobal.userToken;


   //   var response = await http.post(Uri.parse(url1), body:{});
      print(url1);

      print("email:"+email.toString());
      print("user_name:"+user_name.toString());
      print("city:"+city);
      print("ikt:"+ikt);
      print("branch:"+branch);
      print("branch_type:"+branch_type);
      print("mobile:"+mobile.toString());
      print("token:"+UserGlobal.userToken);

      var response = await http.post(Uri.parse(url), body:
      {'service':'register_student','email' : email.toString(),
        'user_name' : user_name,
        'city' : city.toString(),
        'ikt':ikt,

        'branch':branch,
        'branch_type':branch_type,
        'mobile':mobile,
        'passport':passport,
        'national_number':national_number.toString(),
        'year':UserGlobal.year,
        'diff_type':UserGlobal.diff_type,
        'm_type':UserGlobal.m_type,
        'cycle':UserGlobal.cycle,
        'token':UserGlobal.userToken,
      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));

      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        messsage=data['message'];
        if(data['status'].toString()=='true')
        {
          UserGlobal.student_id=data['info']['STUDENT_ID'];
          print('STUDENT_ID:'+ UserGlobal.student_id);
         UserGlobal.sudent=Student.fromJson(data['info']);
          return true;

        }

        else
        {
          this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
          return false;
        }
      }
      if (response.statusCode == 1001)
      {
        //"Please fill requested info correctly"
        this.result= 'الرجاء ملء المعلومات المطلوبة بشكل صحيح';
        return false;
      }
      else{
        this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
        return false;

      }
    }
    catch(e)
    {

      this.result=e.toString();
      return false;

    }
  }



  Future<bool> update_student( String email,String user_name,
      String student_id,String student_email,String mobile,
      String passport,String national_number) async{
    try{


      String url1="http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=update_student&user_name="+user_name;
      url1+="&student_id="+student_id+"&student_email="+student_email+"&mobile="+mobile+"&passport="+passport;
      url1+="&national_number="+national_number+"&token="+UserGlobal.userToken;

     //http://e-gate.dtt.com.qa:8080/mofa_api/services.php?
    // service=update_student&user_name=MU963944233037&student_id=2120111208&
    // student_email=info@e-gate.me&mobile=963954477775&passport=222&
      // national_number=5555&token=cb242fff47cb82d6c692f45cd296dce3
      //   var response = await http.post(Uri.parse(url1), body:{});
      print(url1);
      print(url);
      print("email:"+email.toString());
      print("user_name:"+user_name.toString());
      print("student_id:"+student_id);
      print("student_email:"+student_email);
      print("mobile:"+mobile);
      print("mobile:"+mobile);
      print("national_number:"+national_number.toString());
      print("passport:"+passport);

      var response = await http.post(Uri.parse(url), body:
      {'service':'update_student'
        ,'email' : email.toString(),
        'user_name' : user_name,
        'student_id' : student_id.toString(),
        'student_email':student_email,
        'ikt' :UserGlobal.sudent.ikt,
        'branch' :UserGlobal.sudent.branch,

        'mobile':mobile,

        'passport':passport,
        'national_number':national_number.toString(),
        'token':UserGlobal.userToken,
      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));

      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        messsage=data['message'];
        if(data['status'].toString()=='true')
        {
          UserGlobal.student_id=data['info']['STUDENT_ID'];
          print('STUDENT_ID:'+ UserGlobal.student_id);
          return true;

        }

        else
        {
          this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
          return false;
        }
      }
      if (response.statusCode == 1001)
      {
        //"Please fill requested info correctly"
        this.result= 'الرجاء ملء المعلومات المطلوبة بشكل صحيح';
        return false;
      }
      else{
        this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
        return false;

      }
    }
    catch(e)
    {

      this.result=e.toString();
      return false;

    }
  }

  Future<bool> resend_student_code( String user_name,String student_id,String ikt,String branch,
     ) async{
    try{

      /*
      http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=resend_student_code&
      user_name=MU963944233037&student_id=22001001022683&branch=1&ikt=22683&token=7b7c25f9119fc46857f041e883fd7b20
       */

      print(url);

      print("user_name:"+user_name.toString());
      print("student_id:"+student_id);
      print("ikt:"+ikt);
      print("branch:"+branch);
      //print("branch_type:"+branch_type);
     // print("mobile:"+mobile.toString());
      print("token:"+UserGlobal.userToken);
      var response = await http.post(Uri.parse(url), body:
      {'service':'resend_student_code',
        'user_name' : user_name,
        'student_id' : student_id.toString(),
        'ikt':ikt,

        'branch':branch,
       // 'branch_type':branch_type,
       // 'mobile':mobile,
        //'passport':passport,
        //'national_number':national_number.toString(),
        'token':UserGlobal.userToken,
      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        messsage=data['message'];
        if(data['status'].toString()=='true')
        {
          UserGlobal.student_id=data['info']['STUDENT_ID'];
          print('STUDENT_ID:'+ UserGlobal.student_id);
          return true;

        }

        else
        {
          this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
          return false;
        }
      }
      if (response.statusCode == 1001)
      {
        //"Please fill requested info correctly"
        this.result= 'الرجاء ملء المعلومات المطلوبة بشكل صحيح';
        return false;
      }
      else{
        this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
        return false;

      }
    }
    catch(e)
    {

      this.result=e.toString();
      return false;

    }
  }





  Future<bool> register( String email,String user_name,String fName,String lName,String country,String password,String mobile) async{
    try{
      //http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=register&
      // email=smandarb@gmail.com&user_name=MU963944233037&mobile=963944233037&country=SY&password=123456&fname=باسل&lname=
print(url);
      print("email:"+email);
      print("user_name:"+user_name);
      print("fname:"+fName);
      print("lname:"+lName);
      print("country:"+country);
      print("password:"+password);
      print("mobile:"+mobile);
      var response = await http.post(Uri.parse(url), body:
      {'service':'register','email' : email,
        'user_name' : user_name,
        'fname' : fName,
        'lname':lName,

        'country':country,
        'password':password,
        'mobile':mobile
      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
UserGlobal.userName=user_name;
UserGlobal.mobile=mobile;
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        messsage=data['message'];
        if(data['status'].toString()=='true')
        {
          UserGlobal.userName=user_name;
         /* Map dataInfo = data['info'];
          //print('Response status: ${dataInfo}');
          String id=dataInfo['ID'].toString();
          // print('Response status: $id}');
          String un=dataInfo['FName'].toString()+' '+dataInfo['LName'].toString();
          String token=dataInfo['TOKEN'].toString();*/
        /*  UserGlobal.userMail=userName;


          this.result='true';
          UserGlobal.userName=un;

          UserGlobal.userToken=token;
          UserGlobal.uid=id;*/
          // addUserToSF(token,un,id,userName);
          // print(un);
          return true;

        }

        else
        {
          this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
          return false;
        }
      }
      if (response.statusCode == 1001)
      {
        //"Please fill requested info correctly"
        this.result= 'الرجاء ملء المعلومات المطلوبة بشكل صحيح';
        return false;
      }
      else{
        this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
        return false;

      }
    }
    catch(e)
    {

      this.result=e.toString();
      return false;

    }
  }
  Future<bool> update_password( String old,String newp,String conf
      ) async{
    try{
      //   http://thebestinsyria.net/media/dev/site/services.php?service=change_password&old_password=984088717&new_password=1234&
      // confirm_new_password=1234&email=smandarb@gmail.com&token=22abc57e96aa5a61e63ba21d9963a29b

      var response = await http.post(Uri.parse(url), body:
      {'service':'change_password',
        'email' : UserGlobal.userMail,

        'old_password' : old,
        'new_password':newp,
        'confirm_new_password':conf,

        'token':UserGlobal.userToken.toString(),
      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          Map dataInfo = data['info'];
          //print('Response status: ${dataInfo}');

          return true;

        }

        else
        {
          this.result='حدث خطأ . لم يتم تعديل المعلومات';
          return false;
        }
      }
      if (response.statusCode == 1001)
      {
        //"Please fill requested info correctly"
        this.result= 'الرجاء ملء المعلومات المطلوبة بشكل صحيح';
        return false;
      }
      else{
        this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
        return false;

      }
    }
    catch(e)
    {

      this.result=e.toString();
      return false;

    }
  }
  Future<bool> update_profile( String email,String profile_email,String fName,String lName,String country,int sex, String mobile) async{
    try{
     // http://e-gate.dtt.com.qa:8080/mofa_api/services.php?service=update_profile
      // &email=MU963944233037&fname=%D8%A8%D8%A7%D8%B3%D9%84&lname=%D8%A7%D8%B3%D9%85%D9%86%D8%AF%D8%B1&
      // mobile=963944233037&
      // profile_email=smandarb@gmail.com&sex=1&country=1&token=cb242fff47cb82d6c692f45cd296dce3
      var response = await http.post(Uri.parse(url), body:
      {'service':'update_profile','email' : email,
        'profile_email' : profile_email,
       // 'profile_email':email,
        'fname' : fName,
        'lname':lName,
        'sex':sex.toString(),
        'mobile':mobile,
        'country':country,
        'token':UserGlobal.userToken.toString(),
      }).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          Map dataInfo = data['info'];
          //print('Response status: ${dataInfo}');
          UserGlobal.ActiveAccount = dataInfo['ActiveAccount'].toString();

            String id = dataInfo['ID'].toString();
            // print('Response status: $id}');
            UserGlobal.FName = dataInfo['FName'].toString();
            UserGlobal.LName =  dataInfo['LName'].toString();
            String token = dataInfo['TOKEN'].toString();
            //ActiveAccount
          //  UserGlobal.activeAccount = dataInfo['ActiveAccount'].toString();
            //ActiveAccount
            UserGlobal.profile_email=dataInfo['EMail'].toString();
            UserGlobal.mobile=dataInfo['Mobile'].toString();
            print('mobile: ${ UserGlobal.mobile}');
            UserGlobal.sex=dataInfo['Sex'].toString();
          userName=dataInfo['UserName'].toString();
            print('Response status: $userName}');
            String fbUser_name = userName;
            UserGlobal.userMail = userName;

            // UserGlobal.fbUser_name=userName;

            //  UserGlobal.name=un;
            this.result = 'true';
            UserGlobal.userName = userName;
            UserGlobal.userToken = token;
            UserGlobal.uid = id;

            addUserToSF(token, userName, id, userName, fbUser_name, UserGlobal.activeAccount, UserGlobal.profile_email ,
                UserGlobal.FName, UserGlobal.LName, UserGlobal.sex, UserGlobal.mobile);

            return true;

        }

        else
        {
          this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
          return false;
        }
      }
      if (response.statusCode == 1001)
      {
        //"Please fill requested info correctly"
        this.result= 'الرجاء ملء المعلومات المطلوبة بشكل صحيح';
        return false;
      }
      else{
        this.result= 'حدث خطأ أثناء تسجيل الاستراك الرجاء إعادة التسجي';
        return false;

      }
    }
    catch(e)
    {

      this.result=e.toString();
      return false;

    }
  }


  Future<User_Info> get_user_info( String request_id) async{
    print('------------get_user_info-------${UserGlobal.userMail.toString()}----------');
    User_Info user_info= new User_Info();
    try{

      //int rate=rating.toInt();
      var response = await http.post(Uri.parse(url), body:
      {'service':'update_profile',
        'profile_email':UserGlobal.profile_email.toString(),

        'token':UserGlobal.userToken.toString(),}
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));

      print('-----------user_info------------jj}');
      print(response.body);
      if (response.statusCode == 200) {

        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        //print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          print('info:${data['info']}');
          user_info = User_Info.fromJson(data['info']);
          print('-----------user_info------------${user_info.FName}');
          return user_info;

        }

        else
        {
          this.result='اسم المستخدم أو كلمة المرور غير صحيحة';
          return user_info;
        }
      }
      else
      {
        // addUserToSF('-2','-2','-2');
        return user_info;
      }
    }
    catch(e)
    {
      this.result=e.toString();
      return user_info;

    }
  }




  Future<Student_code> get_student_code( String student_id) async{
//print('------------get_user_info-------${UserGlobal.userMail.toString()}----------');
    Student_code user_info= new Student_code();
    try{

      //int rate=rating.toInt();
      var response = await http.post(Uri.parse(url), body:
      {'service':'student_code',
        'student_id':student_id,
        'user_name':UserGlobal.userName,
      'ikt':   UserGlobal.sudent.ikt,
        'branch':   UserGlobal.sudent.branch,
        'token':UserGlobal.userToken.toString(),}
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));

      print('-----------user_info------------jj}');
     print(response.body);
      if (response.statusCode == 200) {

        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        //print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          print('info:${data['info']}');
          user_info = Student_code.fromJson(data['info']);
          print('-----------user_info------------${user_info.STUDENT_CODE}');
          return user_info;

        }

        else
        {
          this.messsage=data['message'];
          return user_info;
        }
      }
      else
      {
        // addUserToSF('-2','-2','-2');
        return user_info;
      }
    }
    catch(e)
    {
      this.result=e.toString();
      return user_info;

    }
  }

  Future<Student_code> get_student_result( String student_id) async{
//print('------------get_user_info-------${UserGlobal.userMail.toString()}----------');
    Student_code user_info= new Student_code();
    try{

      //int rate=rating.toInt();
      var response = await http.post(Uri.parse(url), body:
      {'service':'student_result',
        'student_id':student_id,
        'user_name':UserGlobal.userName,

        'token':UserGlobal.userToken.toString(),}
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));

      print('-----------user_info------------jj}');
      print(response.body);
      if (response.statusCode == 200) {

        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        //print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          print('info:${data['info']}');
          user_info = Student_code.fromJson(data['info']);
        //  print('-----------user_info------------${user_info.STUDENT_CODE}');

          return user_info;

        }

        else
        {
          this.messsage=data['message'];
          return user_info;
        }
      }
      else
      {
        // addUserToSF('-2','-2','-2');
        return user_info;
      }
    }
    catch(e)
    {
      this.result=e.toString();
      return user_info;

    }
  }







  Future<bool> reset_password( String userName) async{
    try{
      var response = await http.post(Uri.parse(url), body:
      {'service':'reset_password','email' : userName,
      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String checkStatus= data['status'].toString();
        print( '--------------------------------$checkStatus');
        if(data['status'].toString()=='true')
        {
          Map dataInfo = data['info'];
          this.result='true';

          return true;

        }

        else
        {
          try {
            this.result = data['message'].toString();
          }
          catch(e)
          {}
          return false;
        }
      }
      else
      {
        // addUserToSF('-2','-2','-2');
        return false;
      }
    }
    catch(e)
    {
      this.result=e.toString();
      return false;

    }
  }





  Future< bool >  confirm_request_cost(String rid) async{
   bool res=false;
    try{
      //consultants&category=2
      var response = await http.post(Uri.parse(url), body:
      {'service':'confirm_request_cost',
        'rid':rid,
        'email':UserGlobal.userMail.toString(),
        'token':UserGlobal.userToken.toString(),

      }
      ).timeout( Duration(seconds: timeout)).timeout( Duration(seconds: timeout));
      // var response = await http.post(url1);
      print(response.body);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // print( data['status'].toString());
        if(data['status'].toString()=='true')
        {

         return true;


        }
        else
        {
         return false;
        }
      }
      else
      {
        result="Could n't connect to the server!";
        return false;
      }
    }
    catch(e)
    {
      result=e.toString();
      print('error:$result');
      return false;
    }
   return false;
  }
//conultant_comments






}

