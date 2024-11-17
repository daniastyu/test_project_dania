
class Branches{

  String ID;
  String Name;
  String Icon;
List<String> Types;
  Branches({this.ID,this.Name,this.Icon
  });

  factory Branches.fromJson(Map<String, dynamic> json) {
    return Branches(
      ID: json["ID"] as String,
      Name: json["Name"] as String,
      Icon: json["Icon"] as String,
    //  Types: json["Types"] as List<String> ,
    );
  }
}

class Links{

  String facebook;
  String ministry;
  String mofa;
  String phone;
  String email;

  Links({this.facebook,this.ministry,this.mofa,this.phone,this.email
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      facebook: json["facebook"] as String,
      ministry: json["ministry"] as String,
      mofa: json["mofa"] as String,
      phone: json["phone"] as String,
      email: json["email"] as String,
    );
  }
}
class LinkInfo{

  String name;
  String url;
  String icon;


  LinkInfo({this.name,this.url,this.icon
  });


}
class ListItem {
  String ID;
  String Name;

  ListItem({this.ID, this.Name});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
      ID: json["ID"] as String,
      Name: json["Name"] as String,
    );
  }
}
class Mofas{

  String MofaType;
  String MofaName;
  String MofaIcon;
  String MofaURL;
  String TotalFees;
  String FeeID;
  String CardType;



  Mofas({this.MofaType,this.MofaName,this.MofaIcon,this.MofaURL,
    this.TotalFees,this.FeeID,this.CardType
  });


  factory Mofas.fromJson(Map<String, dynamic> json) {
    return Mofas(
      MofaType: json["MofaType"] as String,
      MofaName: json["MofaName"] as String,
      MofaIcon: json["MofaIcon"] as String,
      MofaURL: json["MofaURL"] as String,
      TotalFees: json["TotalFees"] as String,
      FeeID: json["FeeID"] as String,
      CardType: json["CardType"] as String,


    );
  }

}


class Hs_types{

  String ID;
  String Name;
List<ListItem> special_list=new List<ListItem>();



  Hs_types({this.ID,this.Name,
  });


  factory Hs_types.fromJson(Map<String, dynamic> json) {
    return Hs_types(
      ID: json["ID"] as String,
      Name: json["Name"] as String,
    );
  }

}

class Gen_news{

  String id;
  String url;
  String timestamp;
  String subject;
  String photo;

  String description;



  Gen_news({this.id,this.url,this.timestamp,this.subject,this.description,
    this.photo,

  });


  factory Gen_news.fromJson(Map<String, dynamic> json) {
    return Gen_news(
      id: json["id"] as String,
      url: json["url"] as String,
      timestamp: json["timestamp"] as String,
      subject: json["subject"] as String,

      photo: json["photo"] as String,

      description: json["description"] as String,


    );
  }

}


class Student{

  String student_id;
  String user_id;
  String year;
  String branch_type;
  String ikt;
  String city;
  String city_name;
  String career;

  String nationality_name;
  String branch;
  String name;
  String fc_marks;
  String sc_marks;
  String student_mofa_code;
  String m_branch;
  String nationality_id;
  String link_activated;
String link_status;
  String link_email;
  String link_mobile;
  String national_number;
  String special;
  String cycle;
  String mtype;






  Student({this.student_id,this.user_id,this.ikt,this.city,this.nationality_name,
    this.city_name,this.branch, this.name, this.fc_marks, this.sc_marks,this.nationality_id,
    this.student_mofa_code,this.link_activated,this.link_status, this.link_email,this.link_mobile,
    this.national_number,this.branch_type,this.year, this.special,
    this.cycle,this.mtype,this.career,this.m_branch

  });


  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      student_id: json["student_id"] as String,
      user_id: json["user_id"] as String,
      ikt: json["ikt"] as String,
      city: json["city"] as String,
      year: json["year"] as String,
      cycle: json["cycle"] as String,
      mtype: json["mtype"] as String,
      city_name: json["city_name"] as String,
      branch: json["branch"] as String,
      name: json["name"] as String,
      fc_marks: json["fc_marks"] as String,
      sc_marks: json["sc_marks"] as String,
      nationality_id: json["nationality_id"] as String,
      nationality_name: json["nationality_name"] as String,
      student_mofa_code: json["student_mofa_code"] as String,
      link_activated: json["link_activated"] as String,
        link_status: json["link_status"] as String,
      national_number: json["national_number"] as String,
      link_email: json["link_email"] as String,
      link_mobile: json["link_mobile"] as String,
        branch_type: json["branch_type"] as String,
        special: json["special"] as String,
        career: json["career"] as String,
        m_branch: json["m_branch"] as String,

    );
  }

}

class live_streamsList{

  String id;
  String name;
  String active;
  String icon;
 List<Streams>  streams_list;



  live_streamsList({this.id,this.name,this.active,this.icon,
    this.streams_list,

  });


  factory live_streamsList.fromJson(Map<String, dynamic> json) {
    return live_streamsList(
      id: json["id"] as String,
      name: json["name"] as String,
      active: json["active"] as String,
      icon: json["icon"] as String,

     // streams_list: json["streams"] as List<dynamic>,

    );
  }

}

class Bill{

  String student_id;
  String user_id;
  String invoice_id;
  String subscription;
  String is_paid;
  String payment_ref;
  String payment_info;
  String amount;




  Bill({this.student_id,this.user_id,this.invoice_id,this.subscription,
    this.is_paid,this.payment_ref, this.payment_info, this.amount

  });


  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      student_id: json["student_id"] as String,
      user_id: json["user_id"] as String,
      invoice_id: json["invoice_id"] as String,
      subscription: json["subscription"] as String,
      is_paid: json["is_paid"] as String,
      payment_ref: json["payment_ref"] as String,
      payment_info: json["payment_info"] as String,
      amount: json["amount"] as String,

      // streams_list: json["streams"] as List<dynamic>,

    );
  }

}


class Streams{

  String id;
  String source_name;
  String type;
  String icon;
  String code;

  //String description;



  Streams({this.id,this.source_name,this.type,this.icon,this.code,
   // this.photo,

  });


  factory Streams.fromJson(Map<String, dynamic> json) {
    return Streams(
      id: json["id"] as String,
      source_name: json["source_name"] as String,
      type: json["type"] as String,
      icon: json["icon"] as String,

      code: json["code"] as String,

      //description: json["description"] as String,


    );
  }

}


class File_Name_path{

  String name;
  String path;
  
  File_Name_path({this.name,this.path
  });



}



class NotificationArchive{

  String id;
  String url;
  String topic;
  String timestamp;
  String subject;

  String photo;
  String message;
  String notification_type;

  String source;




  NotificationArchive({this.id,this.url,this.timestamp,this.subject,this.message,
    this.notification_type,this.topic,this.photo,this.source

  });


  factory NotificationArchive.fromJson(Map<String, dynamic> json) {
    return NotificationArchive(
      id: json["id"] as String,
      url: json["url"] as String,
      timestamp: json["timestamp"] as String,
      message: json["message"] as String,
      photo:json["photo"] as String,
      /* subject: json["subject"] as String,
      topic:json["topic"] as String,

      source:json["source"] as String,

        notification_type: json["notification_type"] as String,*/


    );
  }

}


class Student_code{

  String STUDENT_ID;
  String Name;
  String STUDENT_CODE;

  String Is_CONFIRMED;

  String email;
  String mobile;
  String RESULT;






  Student_code({this.STUDENT_ID,this.Name,
  this.STUDENT_CODE,
    this.Is_CONFIRMED,
    this.email,
    this.mobile,
    this.RESULT


  });


  factory Student_code.fromJson(Map<String, dynamic> json) {
    return Student_code(
      STUDENT_ID: json["STUDENT_ID"] as String,
      Name: json["Name"] as String,
      STUDENT_CODE: json["STUDENT_CODE"] as String,
      Is_CONFIRMED: json["Is_CONFIRMED"] as String,
      email:json["email"] as String,
      mobile:json["mobile"] as String,
      RESULT:json["RESULT"] as String,
    );
  }

}

class Search_Form{

  String keys;
 List<Search_Element> category;
  List<Search_Element> source;



  Search_Form({this.keys,this.category,this.source,

  });


  factory Search_Form.fromJson(Map<String, dynamic> json) {
    return Search_Form(
      keys: json["keys"] as String,
      category: json["category"] as  List<Search_Element>,
      source: json["source"] as  List<Search_Element>,

    );
  }

}

class Search_Element{

  String number;
  String name;


  Search_Element({this.number,this.name,

  });


  factory Search_Element.fromJson(Map<String, dynamic> json) {
    return Search_Element(
      number: json["number"] as String,
      name: json["name"] as String,


    );
  }

}




class Intro{
  String page_data;
  String photo;
  Intro({this.page_data,this.photo,
  });
  factory Intro.fromJson(Map<dynamic, dynamic> json) {
    return Intro(
      page_data: json["page_data"] as String,
      photo: json["photo"] as String,
    );
  }

}


class Pdf_Element{
  String edition_number;
  String edition_file;
  String edition_date;
  String subject;
  String url;
  String id;
  Pdf_Element({this.edition_number,this.edition_file,
    this.url,this.edition_date,this.subject, this.id
  });
  factory Pdf_Element.fromJson(Map<dynamic, dynamic> json) {
    return Pdf_Element(
      edition_number: json["edition_number"] as String,
      edition_file: json["edition_file"] as String,
      edition_date: json["edition_date"] as String,
      url: json["url"] as String,
        subject: json["subject"] as String,
        id: json["id"] as String,
    );
  }

}

class Send_request_fields{

  String key;
  String type;
  String label;
  String values;
  String values_entered;
  String hint;
  String required;

  Send_request_fields({this.key,this.type,this.label,this.values,this.hint,this.required,

  });


  factory Send_request_fields.fromJson(Map<String, dynamic> json) {
    return Send_request_fields(
        key: json["key"] as String,
        type: json["type"] as String,
        label: json["label"] as String,
        values: json["values"] as String,
        hint: json["hint"] as String,
        required: json["required"] as String,

    );
  }

}