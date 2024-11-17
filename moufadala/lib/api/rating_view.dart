class Rating_view
{
  String rate_id;
  String rate;
  String message;
  String rate_date;




  Rating_view({this.rate_id,this.rate,this.message,
    this.rate_date,
  });


  factory Rating_view.fromJson(Map<String, dynamic> json) {
    return Rating_view(
      rate_id: json["rate_id"] as String,
      rate: json["rate"] as String,
      message: json["message"] as String,
      rate_date: json["rate_date"] as String,



    );
  }


}