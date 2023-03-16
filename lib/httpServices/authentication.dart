import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class Authentication {
  Future<dynamic> Authenticatehttp(
      String email, String password, String urlSegment) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${WebApiKey}';
    try {
      var body = {
        'email': email,
        'password': password,
        'returnSecureToken': true
      };
      final response = await http.post(Uri.parse(url), body: jsonEncode(body));

      var data = jsonDecode(response.body);
 
        return data;
    } catch (e) {
      return 'Please Try Again Later';
    }
  }
}
