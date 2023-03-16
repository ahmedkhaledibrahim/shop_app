import 'package:flutter/material.dart';

Widget ModifiedTextFormField(String label, TextEditingController? controller, bool obsecure,TextInputType keyboardType) {
  return TextFormField(
    controller: controller,
    obscureText: obsecure,
    keyboardType: keyboardType,

    validator: (value) {
      if (value!.isEmpty) {
        return 'Please Enter Your  ${label}';
      }
    },
    decoration: InputDecoration(
      labelText: label,
    ),
  );
}
