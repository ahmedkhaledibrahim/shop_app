
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recap/providers/authenticationProvider.dart';


class ShopSharedPreferences {
  login(String token, String expiryDate, String userId, bool isAuth) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('token', token);
    sharedPrefs.setString('userId', userId);
    sharedPrefs.setString('expiryDate', expiryDate);
    sharedPrefs.setBool('isAuth', isAuth);
  }

  Future<bool> getAuthCondition() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if(sharedPrefs.getBool('isAuth') == null){
      sharedPrefs.setBool('isAuth', false);
    }
    bool isAuth = sharedPrefs.getBool('isAuth')!;
    if(sharedPrefs.getString('expiryDate') != null){
      String expiryDate = sharedPrefs.getString('expiryDate')!;
      if (expiryDate != '') {
        DateTime expirationDate = DateTime.parse(expiryDate);
        if (expirationDate.isAfter(DateTime.now())) {
          print(isAuth);
          return isAuth;
        } else {
          isAuth = await autoLogOut();
          print(isAuth);
          return isAuth;
        }
      }
    }
     else {
      return false;
    }
     return false;
  }

  Future<bool> autoLogOut() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool('isAuth', false);
    sharedPrefs.setString('token', '');
    sharedPrefs.setString('userId', '');
    sharedPrefs.setString('expiryDate', '');
    bool isAuth = sharedPrefs.getBool('isAuth')!;
   
    return isAuth;
  }

  Future<String> get userId async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString('userId')!;
  }

  Future<String> get idToken async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString('token')!;
  }
}
