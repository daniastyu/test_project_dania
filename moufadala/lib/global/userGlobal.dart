

import 'package:moufadala/api/serviceClass.dart';

class UserGlobal{

  static Student sudent=new Student();

  static String Notification_type='0';
  static String mofa_Id='0';
  static String message;
  static String activation_type="0";
  static String student_id="";
  static String mType="0";
  static String cycle="0";
  static String ikt="0";


  static String sType="2";
  static String career="2";

  //static String student_id="";
  static List<ListItem> citieslist=new List<ListItem>();
  static List<ListItem> careerslist=new List<ListItem>();
  static List<ListItem> brancheslist=new List<ListItem>();
  static List<Hs_types> hs_types_list=new List<Hs_types>();
  static List<ListItem> hs_sub_branches_list=new List<ListItem>();
  static List<ListItem> hs_acceptance_list=new List<ListItem>();
  static Links links= new  Links ();
  static Mofas mofas= new Mofas();
  static List<LinkInfo> linkInfoList= new List<LinkInfo>();
  static Branches branche=new Branches();
  static String activeAccount='0';
  static String mobile='0';
  static String diff_type='0';
  static String m_type='0';


  static String year='0';
  static String sex='0';
  static String FName='0';
  static String LName='0';
  static String nid='0';
  static String notificationSearchtype='0';
  static String voiceType='0';
  static double screen_heigh=0;
  static double volume = 0.5;
  static double pitch = 1.0;
  static double rate = 0.7;
  static String ActiveAccount='-1';
  static String notifi_details=' ';
  static String userName = '';
  static String notificatio_searchType = '0';
  static String app_name = 'ميديا';
  static String service_price = '0';
  static String search_key = '';
  static String search_Category = '';
  static String search_Source = '';
  static String userMail='';
  static String profile_email='';
  static String uid = '';
  static String userToken = '';
  static String fbToken = '';
  static int lang = 0;
  static String consultant_name="0";
  static String my_balance="0";
  static String  fbUser_name='';
  static String consultant_id="0";
  static bool user_login=false;
  static String transfer_to_me='';
  static String transfer_to_Other='';
  static String payment_id='';
  static String new_url='';
  static String url_type='0';
  static bool subscribe=false;
  static List<String> slider_list= new List<String>();



}

class Category{
  // Socket
  static bool sendRequest=false;
  static int typeAdvertisement=0;
  static String nameAdvertismnt = '';
  static String name = '';// service name
  static int id=0;// service Id
  static int sound_duration=0;
  static int photos_count=0;
  static String consultant_id="0";
  static String consultant_name="0";
  static String group="0";
  static String discount="0";

//static String uid = '';

}

class App_info{
  // Socket

  static String site_url = 'http://e-gate.dtt.com.qa:8080/mofa_api/services.php';
  static String app_name = 'مفاضلة وزارة التعليم العالي والبحث العلمي';



}