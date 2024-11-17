
class Consultants{

  String private_id;
  String first_name;
  String last_name;
  String sex;
  String user_name;
  String email;
  String is_online;
  String mobile;
  String consultant_id;
  String photo;
  String rate;
  String time_to_reply;
  String wait_list;
  String service_price;
  String service_discount;
  String cv;
  List<ConsultantService>  services;

 // String services;
  Consultants({this.private_id,this.first_name,this.last_name,this.sex,this.user_name
    ,this.email,
    this.mobile,
    this.is_online,
    this.consultant_id,
    this.photo,
    this.rate,
    this.time_to_reply,
    this.wait_list,
    this.services,
    this.cv
 //   this.services
  });


  factory Consultants.fromJson(Map<String, dynamic> json) {
    return Consultants(
        private_id: json["private_id"] as String,
        first_name: json["first_name"] as String,
        last_name: json["last_name"] as String,
        sex: json["sex"] as String,
        user_name: json["user_name"] as String,
        email: json["email"] as String,
        is_online: json["is_online"] as String,
        mobile: json["mobile"] as String,
        consultant_id: json["consultant_id"] as String,
        photo: json["photo"] as String,
      rate: json["rate"] as String,
      time_to_reply: json["time_to_reply"] as String,
       wait_list: json["wait_list"] as String,
      cv: json["cv"] as String,
       //services: json["services"] as   List<Map<String, String> >
    );
  }

}


class ConsultantService{

  String service_id;
  String service_name;
  String service_price;
  String service_discount;
  String service_photo;

  ConsultantService({this.service_id,this.service_name,this.service_price,this.service_discount,
    this.service_photo

  });


  factory ConsultantService.fromJson(Map<String, dynamic> json) {
    return ConsultantService(
      service_id: json["service_id"] as String,
      service_name: json["service_name"] as String,
      service_price: json["service_price"] as String,
      service_discount: json["service_discount"] as String,
      service_photo: json["service_photo"] as String,


    );
  }

}

//conultant_comments
class conultant_comments{

  String sender_id;
  String sender_name;
  String post_date;
  String rate;
  String comment;

  conultant_comments({this.sender_id,this.sender_name,this.post_date,this.rate,
    this.comment

  });


  factory conultant_comments.fromJson(Map<String, dynamic> json) {
    return conultant_comments(
      sender_id: json["sender_id"] as String,
      sender_name: json["sender_name"] as String,
      post_date: json["post_date"] as String,
      rate: json["rate"] as String,
      comment: json["comment"] as String,


    );
  }

}