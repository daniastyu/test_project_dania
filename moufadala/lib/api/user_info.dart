class User_Info
{
  String FName;
  String LName;
  String Sex;
  String Mobile;
  String EMail;
  String use_name;
 // String Mobile;




  User_Info({this.FName,this.LName,this.Sex,
    this.Mobile,this.EMail,this.use_name
  });


  factory User_Info.fromJson(Map<String, dynamic> json) {
    return User_Info(
      FName: json["FName"] as String,
      LName: json["LName"] as String,
      Sex: json["Sex"] as String,
      Mobile: json["Mobile"] as String,
      EMail: json["EMail"] as String,
      use_name: json["UserName"] as String,



    );
  }


}