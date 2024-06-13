import 'package:tafweed/cubits/order/order_cubit.dart';
import 'package:tafweed/enums.dart';
import 'package:tafweed/models/video.dart';

class Order{
  String? id;
  late String name;
  late Reason reason;
  String? comment;
  late double price;
  OrderStatus? status;
  List<Video> vidoes = [Video(link: "none"), Video(link: "none"), Video(link: "none"), Video(link: "none"),];
  OrderType? type;
  late Gender gender;
  String? payment;
  DateTime? createdAt;

  Order({required this.name, required this.reason, this.comment, required this.price, this.status, 
    this.type, this.gender = Gender.male, this.payment, this.createdAt});
  Order.fromMap(Map map){
    id = map["_id"];
    payment = map["payment"];
    name = map['for'];
    reason = Reason.values[int.parse(map['case']) - 1];
    comment = map['comment'];
    gender = Gender.values[int.parse(map['gender']) - 1];
    type = OrderType.values[int.parse(map['type']) - 1];
    convertFromJsonToVideos(map["videos"]);
    price = 0;
  }

  Map<String, dynamic> toMap(){
    return {
      "for": name,
      "case": reason.index + 1,
      "comment": comment,
      "gender": gender.index + 1,
      "type": type!.index + 1,
    };
  }

  String getType(){
    switch(type){
      case OrderType.ragab: return "رجب";
      case OrderType.shabaan: return "شعبان";
      case OrderType.ramadan: return "رمضان";
      case OrderType.any: return "باقي الشهور";
      case OrderType.fast: return "عاجلة";
      default: return "غير محدد";
    }
  }

  void convertFromJsonToVideos(Map<String, dynamic> videosJson){
    for(int i=0; i<videosJson.values.toList().length; i++){
      String? link = videosJson.values.toList()[i]["link"]; 
      bool approved = videosJson.values.toList()[i]["approved"] != "no"? true: false;
      Video video = Video(link: link, approved: approved);
      vidoes[i] = video;
    }
  }

  String getReason(){
    switch(reason){
      case Reason.died: return "متوفي";
      case Reason.old: return "عاجز";
      case Reason.sick: return "مريض";
      case Reason.other: return "اخر";
    }
  }

  String getStatus(){
    OrderStatus? myStatus;
    if(vidoes[0].approved){
      myStatus = OrderStatus.arrived;
    }
    if(vidoes[1].approved){
      myStatus = OrderStatus.tawaf;
    }
    if(vidoes[2].approved){
      myStatus = OrderStatus.safaAndMarwa;
    }
    if(vidoes[3].approved){
      myStatus = OrderStatus.cuttingHair;
    }
    switch(myStatus){
      case OrderStatus.arrived: return "وصل";
      case OrderStatus.tawaf: return "يطوف";
      case OrderStatus.safaAndMarwa: return "بين الصفا والمروة";
      case OrderStatus.cuttingHair: return "قص الشعر";
      default: return "لم يبدأ";
    }
  }

  String getGender(){
    switch(gender){
      case Gender.male: return "ذكر";
      case Gender.female: return "انثى";
    }
  }
}