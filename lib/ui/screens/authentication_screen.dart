// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/authenticationProvider.dart';
import 'package:recap/constants.dart';
import 'package:recap/shared_preferences.dart';
import 'package:recap/ui/widgets/authentication_card_widget.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);
  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  rich_lilac,
                  light_orange,
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                stops: [0, 1],
              )),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Center(
                          child: Text(
                        'My Shop',
                        style: TextStyle(
                            fontFamily: 'Anton',
                            fontSize: 45,
                            color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 180, 83, 54),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.grey,
                                offset: Offset(0, 2))
                          ])),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthenticationCardWidget()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
