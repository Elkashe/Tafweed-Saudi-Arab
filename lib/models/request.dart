import 'package:tafweed/enums.dart';
import 'package:tafweed/local/cache.dart';
import 'package:tafweed/models/coupon.dart';
import 'package:tafweed/models/package.dart';
import 'package:tafweed/models/person_cases.dart';

class Request{
  int? id;
  Package? package;
  String? personName;
  String? createdAt;
  String? doneDate;
  String? paymentId = "12121212";
  String? discount;
  String? paid;
  String? cost;
  PersonCase? personCase;
  String? comment;
  Gender? gender = Gender.male;
  Coupon? coupon;

  Request({this.id, this.package, this.paid, this.createdAt, this.paymentId, this.discount, this.doneDate, this.personName});
  Request.fromJson(Map<String, dynamic> json){
    id = json["id"];
    package = Package(
      arName: json["name_ar"],
      enName: json["name_en"],
      trName: json["name_tr"],
      urName: json["name_ur"],
      idName: json["name_ind"],
      cost: double.parse(json["cost"]),
    );
    personName = json["name"];
    createdAt = json["created_at"];
    doneDate = json["done_date"];
    paymentId = json["payment_id"] ?? "121212";
    discount = json["discount"];
    paid = json["paid"];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {
      "service_id": package?.id,
      "user_id": Cache.getUserId(),
      "name": personName,
      "gender": gender == Gender.male ? 1 : 2,
      "person_case_id": personCase?.id,
      "comments": comment,
      "created_by": Cache.getUserId(),
    };

    if(coupon != null){
      data["coupon_id"] =  coupon?.id;
    }
    print(data);
    return data;
  }

  String? getCreatedAt(){
    if(createdAt == null) return null;
    var list = createdAt!.split("T");
    return "${ list[0] } ${list[1].split(".")[0]}";
  }
}