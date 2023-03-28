// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recap/httpServices/authentication.dart';
import 'package:recap/providers/FavouriteRepository.dart';
import 'package:recap/providers/ProductsProviders/ProductRepository.dart';
import 'package:recap/providers/authenticationProvider.dart';
import 'package:recap/providers/CartProviders/CartRepository.dart';
import 'package:recap/providers/OrdersProvider/OrderRepository.dart';

import 'package:recap/services/payments.dart';
import 'package:recap/shared_preferences.dart';
import 'package:recap/ui/screens/authentication_screen.dart';
import 'package:recap/ui/screens/product_details_screen.dart';
import 'package:recap/ui/screens/main_screen.dart';

void main(){
 
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool checkIsAuth = false;

  Future<void> checkAuth() async {
    bool isAuth = await ShopSharedPreferences().getAuthCondition();
    if (isAuth == true) {
      setState(() {
        checkIsAuth = true;
      });
    } else {
      setState(() {
        checkIsAuth = false;
      });
    }
  }

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider(),lazy: true,),
        ChangeNotifierProvider(create: (_) => CartRepository()),
        ChangeNotifierProvider(create: (_) => OrderRepository()),
        ChangeNotifierProvider(create: (_) => ProductRepository()),
        ChangeNotifierProvider(create: (_)=> FavouriteRepository()),
      ],
      child: GetMaterialApp(
        title: 'Shop App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Lato',
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white10,
                elevation: 0,
                foregroundColor: Colors.black)),
        // routes: {
        //   '/': (context) => AuthenticationScreen(),
        //   '/product-detail': (context) => ProductDetailsScreen(),
        //   '/home-screen': (context) => HomeScreen()
        // },
        home: checkIsAuth ? MainScreen() : AuthenticationScreen(),
      ),
    );
  }
}
