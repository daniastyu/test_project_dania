

import 'package:moufadala/ui/activateCode.dart';
import 'package:moufadala/ui/changePasswordPage.dart';
import 'package:moufadala/ui/forgetPassword.dart';
import 'package:moufadala/ui/getCompetitionCode.dart';
import 'package:moufadala/ui/loginPage.dart';
import 'package:moufadala/ui/mofaTypes.dart';
import 'package:moufadala/ui/mofasPage.dart';
import 'package:moufadala/ui/myStudentsPage.dart';
import 'package:moufadala/ui/notificationArchive.dart';
import 'package:moufadala/ui/preparingYear.dart';
import 'package:moufadala/ui/profilepage.dart';
import 'package:moufadala/ui/registerPage.dart';
import 'package:moufadala/ui/register_student.dart';
import 'package:moufadala/ui/resultCompotion.dart';
import 'package:moufadala/ui/student_bill.dart';
import 'package:moufadala/ui/studentsListBill.dart';
import 'package:moufadala/ui/studentsToComprion.dart';
import 'package:moufadala/ui/update_linked_Student.dart';
import 'package:moufadala/ui/web_Page.dart';

import 'ui/loading.dart';
import 'ui/home.dart';

class Routes {
  static routes() {
    return {
      Loading.ROUTE_ID: (context) => Loading(),
      Homepage.ROUTE_ID: (context) => Homepage(),
      MofasPage.ROUTE_ID: (context) => MofasPage(),
      LoginPage.ROUTE_ID: (context) => LoginPage(),
      RegisterPage.ROUTE_ID: (context) => RegisterPage(),
      ActivateCodePage.ROUTE_ID: (context) => ActivateCodePage(),
      ChangePawwprdPage.ROUTE_ID: (context) => ChangePawwprdPage(),
      ForgetPasswordPage.ROUTE_ID: (context) => ForgetPasswordPage(),
      Register_student_Page.ROUTE_ID: (context) => Register_student_Page(),
      MyStudentspage.ROUTE_ID: (context) => MyStudentspage(),
      ProfilePage.ROUTE_ID: (context) => ProfilePage(),
      MofaTypespage.ROUTE_ID: (context) => MofaTypespage(),
      NotificationPage.ROUTE_ID: (context) => NotificationPage(),
      StudentsToCompresionpage.ROUTE_ID: (context) => StudentsToCompresionpage(),
      Web_Page.ROUTE_ID: (context) => Web_Page(),
      ResultCompetitionpage.ROUTE_ID: (context) => ResultCompetitionpage(),
      GetCompetitionCodepage.ROUTE_ID: (context) => GetCompetitionCodepage(),
      Update_linked_student_Page.ROUTE_ID: (context) => Update_linked_student_Page(),
      StudentsListBillpage.ROUTE_ID: (context) => StudentsListBillpage(),
      Student_Billpage.ROUTE_ID: (context) => Student_Billpage(),
      PreparingYearPage.ROUTE_ID: (context) => PreparingYearPage(),
      //LoginPage.ROUTE_ID: (context) => LoginPage(),



    };
  }

  static initScreen() {
    return  Loading.ROUTE_ID;
  }
}