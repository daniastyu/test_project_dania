
class RequestSClass{

  String request_id;
  String AdvertiserName;
  String user_id;
  String post_date;
  String category_id;
  String category_name;

  String Subject;
  String AdSide;
  String status;
  String ContactPhone;

      String ContactFax;
  String ContactMobile;
      String ContactWhatsup;
  String ContactEmail;
      String ContactAddress;
  String TotalPrice;
  String status_code;
  Agent agent;





  List<Messages> messages;
  List<FileClass> photo;
  List<FileClass> audio;
  List<FileClass> documents;
  List<Request_Paramater> parameters_list;
  ReplayClass reply;
  RequestSClass({this.request_id,this.user_id,this.post_date,this.category_id,this.status,
    this.audio,this.photo,this.reply,this.AdvertiserName,this.category_name,this.Subject,this.messages,
    this.AdSide, this.ContactPhone,this.ContactFax,this.ContactMobile,this.ContactWhatsup,
    this.ContactEmail  ,this.ContactAddress ,this.parameters_list,
    this.TotalPrice, this.agent,this.status_code,this.documents

  });


  factory RequestSClass.fromJson(Map<String, dynamic> json) {
    return RequestSClass(
        request_id: json["request_id"] as String,
        user_id: json["user_id"] as String,
        post_date: json["post_date"] as String,
        category_id: json["category_id"] as String,
      category_name: json["category_name"] as String,
//this.full_name, this.birth_date,this.mother_name,this.horoscopes,this.gender,this.m_status,
      AdSide: json["AdSide"] as String,
      status: json["status"] as String,
      TotalPrice: json["TotalPrice"] as String,
      ContactPhone: json["ContactPhone"] as String,

      ContactFax: json["ContactFax"] as String,
      ContactMobile: json["ContactMobile"] as String,
      ContactWhatsup: json["ContactWhatsup"] as String,

      ContactEmail: json["ContactEmail"] as String,

      ContactAddress: json["ContactAddress"] as String,

      //agent: json["agent"] as Map<String, dynamic> ,
      Subject: json["Subject"] as String,
      status_code:json["status_code"] as String,
        messages: json["messagse"] as  List<Messages>,
        photo: json["photos"] as List<FileClass>,
        audio: json["audio"] as   List<FileClass>,
      documents: json["documents"] as   List<FileClass>,
      reply: json["reply"] as  ReplayClass,
      AdvertiserName: json["AdvertiserName"] as  String,
    );
  }

}

class Agent
{
  String agent_name;
  String agent_phone;
  String agent_mobile;
  String agent_email;


  Agent({this.agent_name,this.agent_phone,this.agent_mobile,this.agent_email

  });


  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      agent_name: json["agent_name"] as String,
      agent_phone: json["agent_phone"] as String,
      agent_mobile: json["agent_mobile"] as String,

      agent_email: json["agent_email"] as String,
    );
  }


}
class FileClass
{
  String file_path;
  String post_date;
  String file_type;


  FileClass({this.file_path,this.post_date,this.file_type,

  });


  factory FileClass.fromJson(Map<String, dynamic> json) {
    return FileClass(
      file_path: json["file_path"] as String,
      post_date: json["post_date"] as String,
      file_type: json["post_date"] as String,


    );
  }


}

class Request_Paramater
{
  String name;
  String value;
  Request_Paramater({this.name,this.value
  });
}
class Messages
{
  String file_path;
  String post_date;
  String sender;
  String message;
  List<FileClass> photo;
  List<FileClass> audio;

  Messages({this.file_path,this.post_date,this.sender,this.message,this.audio,this.photo

  });


  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      file_path: json["file_path"] as String,
      post_date: json["post_date"] as String,
      sender: json["sender"] as String,
        message: json["message"] as String,
      //photo: json["photos"] as List<FileClass>,
     // audio: json["audio"] as   List<FileClass>,

    );
  }


}


class Topic
{
  String topic_id;
  String topic_description;
  String topic_key;
  String group_key;
  String group_name;
bool value=false;
String participated="0";

  Topic({this.topic_id,this.topic_description,this.topic_key,this.group_key,this.group_name,this.value,
    this.participated

  });


  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topic_id: json["topic_id"] as String,
      topic_description: json["topic_description"] as String,
      topic_key: json["topic_key"] as String,
      group_key: json["group_key"] as String,
      group_name: json["group_name"] as String,
        participated: json["participated"] as String,


    );
  }


}

class ReplayClass
{
  String reply_date;
  String start_date;
  String end_date;
  String consultant_id;
  String consultant_name;
  String reply_message;
  List<FileClass> audio;


  ReplayClass({this.reply_date,this.start_date,this.end_date,
    this.consultant_id,this.consultant_name,this.reply_message,this.audio

  });


  factory ReplayClass.fromJson(Map<String, dynamic> json) {
    return ReplayClass(
      reply_date: json["reply_date"] as String,
      start_date: json["start_date"] as String,
      end_date: json["end_date"] as String,
      consultant_id: json["consultant_id"] as String,
      consultant_name: json["consultant_name"] as String,
      reply_message: json["reply_message"] as String,
      audio: json["audio"] as List<FileClass>,


    );
  }


}