import 'dart:math';

abstract class NotificationsList{
  static List<String> items = [
    "عمرة بدل الأن عن مريض او عاجز",
    "يمكنك الأن حجز عمرة بدل عن متوفي",
    "لا الله ألا انت سبحانك اني كنت من الظالمين",
    "تابع الطواف حول الكعبة الشريفة",
    "تابع السعي بين الصفا والمرة",
    "يمكنك اتمام عمرة عن شخص عاجز",
  ];

  static String getRandomNotification(){
    Random rand = Random();
    int index = rand.nextInt(items.length);
    return items[index];
  }
}