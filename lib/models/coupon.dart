class Coupon{
  int? id;
  String? name;
  String? code;
  String? discountPercent;

  Coupon({this.code, this.discountPercent, this.id, this.name});
  Coupon.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    code = json["code"];
    discountPercent = json["discount_percent"];
  }
}