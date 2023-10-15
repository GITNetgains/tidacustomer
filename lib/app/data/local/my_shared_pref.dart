import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  MySharedPref._();
  static late SharedPreferences _sharedPreferences;
  static const String _id = "id";
  static const String _name = "name";
  static const String _authtoken = "authtoken";
  static const String _phone = "phone";
  static const String _email = "email";
  static const String _avatar = "avatar";
  static const String _sportsdata = "sportsdata";
  static const String _longi = "longi";
  static const String _lati = "lati";
  static const String _city = "city";
  static const String _radius = "100";
  static const String _filtervenue = "venue";
  static const String _filterraduius = "100";
  static const String _fcmTokenKey = "fcm";

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

    static void setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() => _sharedPreferences.getString(_fcmTokenKey);

  static void setName(String name) => _sharedPreferences.setString(_name, name);

  static String? getName() => _sharedPreferences.getString(_name) ?? "";

  static void setid(String id) => _sharedPreferences.setString(_id, id);

  static String? getid() => _sharedPreferences.getString(_id) ?? "";

  static void setauthtoken(String authtoken) =>
      _sharedPreferences.setString(_authtoken, authtoken);

  static String? getauthtoken() =>
      _sharedPreferences.getString(_authtoken) ?? "";

  static void setemail(String email) =>
      _sharedPreferences.setString(_email, email);

  static String? getemail() => _sharedPreferences.getString(_email) ?? "";

  static void setphone(String phone) =>
      _sharedPreferences.setString(_phone, phone);

  static String? getphone() => _sharedPreferences.getString(_phone) ?? "";

  static void setavatar(String avatar) =>
      _sharedPreferences.setString(_avatar, avatar);

  static String? getavatar() => _sharedPreferences.getString(_avatar) ?? "";

  static void setsportsdata(String sportsdata) =>
      _sharedPreferences.setString(_sportsdata, sportsdata);

  static String? getSportsData() =>
      _sharedPreferences.getString(_sportsdata) ?? "";

  static void setlati(String lati) => _sharedPreferences.setString(_lati, lati);

  static String? getlati() => _sharedPreferences.getString(_lati) ?? "";

  static void setlongi(String longi) =>
      _sharedPreferences.setString(_longi, longi);

  static String? getlongi() => _sharedPreferences.getString(_longi) ?? "";

  static void setcity(String city) => _sharedPreferences.setString(_city, city);

  static String? getcity() => _sharedPreferences.getString(_city) ?? "";

  static void setradius(String radius) =>
      _sharedPreferences.setString(_radius, radius);

  static String? getradius() => _sharedPreferences.getString(_radius) ?? "";

  static void setfiltervenue(String filtervenue) =>
      _sharedPreferences.setString(_filtervenue, filtervenue);

  static String? getfiltervenue() =>
      _sharedPreferences.getString(_filtervenue) ?? "";

  static void setfilterradius(String filterraduius) =>
      _sharedPreferences.setString(_filterraduius, filterraduius);

  static String? getfilterradius() =>
      _sharedPreferences.getString(_filterraduius) ?? "";

  static void clearSession() {
    _sharedPreferences.clear();
  }
}
