import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/authenticationProvider.dart';
import 'package:recap/constants.dart';
import 'package:recap/ui/screens/main_screen.dart';
import 'package:recap/ui/widgets/textform_widget.dart';

class AuthenticationCardWidget extends StatefulWidget {
  const AuthenticationCardWidget({Key? key}) : super(key: key);

  @override
  State<AuthenticationCardWidget> createState() =>
      _AuthenticationCardWidgetState();
}

class _AuthenticationCardWidgetState extends State<AuthenticationCardWidget>
    with SingleTickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  TextEditingController PasswordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  bool _isLoading = false;

  var _authMode = AuthMode.Login;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _slideAnimation = Tween<Offset>(begin: Offset(0, -0.15), end: Offset(0, 0))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.fastOutSlowIn));

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  Future<void> submit(value) async {
    if (_formkey.currentState!.validate()) {
      String urlSegment = '';
      if (_authMode == AuthMode.Signup &&
          ConfirmPasswordController.text == PasswordController.text) {
        urlSegment = 'signUp';
        final alert = await value.AuthenticateUser(
            EmailController.text, PasswordController.text, urlSegment);
        if (alert != null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              });
        } else {
          Get.off(MainScreen());
        }
      } else {
        urlSegment = 'signInWithPassword';
        final alert = await value.AuthenticateUser(
            EmailController.text, PasswordController.text, urlSegment);
        if (alert != null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              });
        } else {
          Get.off(MainScreen());
        }
      }
    }
    setState(() {
      _isLoading = true;
    });
    try {} catch (e) {}
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });

      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 320 : 290,
        width: MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ModifiedTextFormField('Email', EmailController, false,
                      TextInputType.emailAddress),
                  ModifiedTextFormField(
                      'Password', PasswordController, true, TextInputType.text),
                  _authMode == AuthMode.Signup
                      ? AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                          child: FadeTransition(
                            opacity: _opacityAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: TextFormField(
                                controller: ConfirmPasswordController,
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                enabled: _authMode == AuthMode.Signup,
                                validator: (value) {
                                  if (value != PasswordController.text ||
                                      value!.isEmpty) {
                                    return 'Please Enter Matched Passwords';
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Confirm Password',
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 10,
                        ),
                  _authMode == AuthMode.Login
                      ? const SizedBox(height: 0)
                      : const SizedBox(height: 20),
                  if (_isLoading) CircularProgressIndicator(),
                  Consumer<AuthenticationProvider>(
                    builder: (context, value, child) => ElevatedButton(
                      onPressed: () async {
                        await submit(value);
                      },
                      child: Text(
                        _authMode == AuthMode.Login ? 'Login' : 'Sign up',
                      ),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(30),
                      // ),
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      // color: Color.fromARGB(255, 104, 48, 31),
                      // textColor:
                      //     Theme.of(context).primaryTextTheme.headline6!.color,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                          '${_authMode == AuthMode.Login ? 'Sign up' : 'Login'} Instead'))
                ],
              ),
            )),
      ),
    );
  }
}
