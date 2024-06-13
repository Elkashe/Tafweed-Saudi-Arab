import 'package:shared_preferences/shared_preferences.dart';
import 'package:tafweed/cubits/gender/gender_cubit.dart';
import 'package:tafweed/enums.dart';

class Cache{
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setLoggedIn() async{
    await sharedPreferences.setBool("login", true);
  }

  static bool? getLoggedIn(){
    return sharedPreferences.getBool("login");
  }

  static Future<void> setUserId(int value) async{
    await sharedPreferences.setInt("userId", value);
  }

  static int? getUserId(){
    return sharedPreferences.getInt("userId");
  }

  static Future<void> setName(String value) async{
    await sharedPreferences.setString("name", value);
  }

  static String? getName(){
    return sharedPreferences.getString("name");
  }

  static Future<void> setPhone(String value) async{
    await sharedPreferences.setString("phone", value);
  }

  static String? getPhone(){
    return sharedPreferences.getString("phone");
  }

  static Future<void> setGender(Gender value) async{
    bool isMale = value == Gender.male ? true : false; 
    await sharedPreferences.setBool("gender", isMale);
  }

  static Gender getGender(){
    bool? isMale = sharedPreferences.getBool("gender");
    if(isMale != null){
      return isMale ? Gender.male : Gender.female;
    }
    return Gender.male;
  }

  static Future<void> setDialCode(String value) async{
    await sharedPreferences.setString("dialCode", value);
  }

  static String? getDialCode(){
    return sharedPreferences.getString("dialCode");
  }

  static Future<void> setCountryId(int value) async{
    await sharedPreferences.setInt("countryId", value);
  }

  static int? getCountryId(){
    return sharedPreferences.getInt("countryId");
  }

  static Future<void> setCountryArName(String value) async{
    await sharedPreferences.setString("countryArName", value);
  }

  static String? getCountryArName(){
    return sharedPreferences.getString("countryArName");
  }

  static Future<void> setLanguage(String value) async{
    await sharedPreferences.setString("language", value);
  }

  static String? getLanguage(){
    return sharedPreferences.getString("language");
  }

   static Future<void> setCountryEnName(String value) async{
    await sharedPreferences.setString("country name", value);
  }

  static String? getCountryEnName(){
    return sharedPreferences.getString("country name");
  }

  static Future<void> clear() async{
    await sharedPreferences.clear();
  }

   static Future<void> setToken(String value) async{
    await sharedPreferences.setString("token", value);
  }

  static String? getToken(){
    return sharedPreferences.getString("token");
  }

  static Future<void> setNotifications(List<String> values) async{
    await sharedPreferences.setStringList("notification", values);
  }

  static List<String>? getNotifications(){
    return sharedPreferences.getStringList("notification");
  }

  static Future<void> setPackagesPrices(List<String> values) async{
    await sharedPreferences.setStringList("prices", values);
  }

  static List<String>? getPackagesPrices(){
    return sharedPreferences.getStringList("prices");
  }

  static Future<void> setCurrencyCode(String value) async{
    await sharedPreferences.setString("currency code", value);
  }

  static String? getCurrencyCode(){
    return sharedPreferences.getString("currency code");
  }

  static Future<void> setCurrencySign(String value) async{
    await sharedPreferences.setString("currency sign", value);
  }

  static String? getCurrencySign(){
    return sharedPreferences.getString("currency sign");
  }

  static Future<void> setCurrencyRate(double value) async{
    await sharedPreferences.setDouble("currency rate", value);
  }

  static double? getCurrencyRate(){
    return sharedPreferences.getDouble("currency rate");
  }
}