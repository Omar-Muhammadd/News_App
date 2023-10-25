import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putBool ({
    required String Key,
    required bool value,
  }) async
  {
    return await sharedPreferences!.setBool(Key, value);
  }

  static bool? getBool  ({
    required String Key,
  })
  {
      return sharedPreferences!.getBool(Key);
  }

}