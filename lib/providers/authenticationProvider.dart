import 'package:flutter/cupertino.dart';
import 'package:recap/models/authentictionModel.dart';
import 'package:recap/httpServices/authentication.dart';
import 'package:recap/shared_preferences.dart';
import 'package:either_dart/either.dart';
import 'package:recap/ui/widgets/errorsAlertDialog.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationModel auth =
      AuthenticationModel(token: '', userId: '', expiryDate: '',isAuth: false);

  Future<dynamic> AuthenticateUser(String email, String password, String urlSegment)async {
    dynamic data =
        await Authentication().Authenticatehttp(email, password, urlSegment);
        print(data);
    if (data['idToken'] != null) {
      auth.token = data['idToken'].toString();
      auth.expiryDate = DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'].toString())))
          .toString();
      auth.userId = data['localId'].toString();
      auth.isAuth = true;
      ShopSharedPreferences().login(auth.token,auth.expiryDate,auth.userId,auth.isAuth);
      notifyListeners();
    }
    else{
      return ErrorsAlertDialog(errorMessage: data['error']['message'].toString());
    }

    
  }

 
}
