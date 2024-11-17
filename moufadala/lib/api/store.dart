class Store
{
  String slice_id;
  String amount_units;
  String amount_usd;
  String name;
  String photo;

  Store({this.slice_id,this.amount_units,this.amount_usd,
    this.name, this.photo
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      slice_id: json["slice_id"] as String,
      amount_units: json["amount_units"] as String,
      amount_usd: json["amount_usd"] as String,
      name: json["name"] as String,
      photo: json["photo"] as String,
    );
  }
}

class Balance
{
  String transfer_id;
  String user_id;
  String post_date;
  String amount_units;
  String amount_usd;
  String transaction_id;
  String payment_info;


  Balance({this.transfer_id,this.user_id,this.post_date,
    this.amount_units, this.amount_usd,this.transaction_id,this.payment_info
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      transfer_id: json["transfer_id"] as String,
      user_id: json["user_id"] as String,
      post_date: json["post_date"] as String,
      amount_units: json["amount_units"] as String,
      amount_usd: json["amount_usd"] as String,
      transaction_id: json["transaction_id"] as String,
      payment_info: json["payment_info"] as String,
    );
  }
}