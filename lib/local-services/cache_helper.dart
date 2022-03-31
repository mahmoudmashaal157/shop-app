import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;

  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void saveData({
    required String key,
    required value
  })async
  {
    if(value is double){
      await sharedPreferences!.setDouble(key, value);
    }
    else if(value is int){
      await sharedPreferences!.setInt(key, value);
    }
    else if (value is bool){
      await sharedPreferences!.setBool(key, value);
    }
    else {
      await sharedPreferences!.setString(key, value);
    }
  }

  static getData({
    required String key
  })async
  {
    return sharedPreferences!.get(key);
  }

  static removeData({
    required String key
  })async
  {
   await sharedPreferences!.remove(key);
  }


}