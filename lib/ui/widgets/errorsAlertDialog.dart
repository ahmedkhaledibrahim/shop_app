import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ErrorsAlertDialog extends StatelessWidget {
  final String errorMessage;
  const ErrorsAlertDialog({Key? key, required this.errorMessage})
      : super(key: key);

  String modifyErrorMessage(String message) {
    if (message.contains('EMAIL_EXISTS')) {
      return 'Email Already Exists';
    } else if (message.contains('INVALID_EMAIL')) {
      return 'Email Not Found';
    } else if (message.contains('WEAK_PASSWORD')) {
      return 'Try Stronger Password';
    } else if (message.contains('EMAIL_NOT_FOUND')) {
      return 'This Email Not Found';
    } else if (message.contains('INVALID_PASSWORD')) {
      return 'Invalid Password';
    } else if (message != '') {
      return message;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Something Wrong Happened !',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red[900]),
      ),
      content: Text(modifyErrorMessage(errorMessage)),
      actions: [
        ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
