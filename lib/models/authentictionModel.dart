
class AuthenticationModel{
  String token;
  String userId;
  String expiryDate;
  bool isAuth;
  
  AuthenticationModel({
    required this.token,
    required this.userId,
    required this.expiryDate,
    required this.isAuth,
  });
}