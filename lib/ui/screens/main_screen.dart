import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recap/ui/screens/cart_screen.dart';
import 'package:recap/ui/screens/favourites_screen.dart';
import 'package:recap/ui/screens/home_screen.dart';
import 'package:recap/ui/screens/menu_screen.dart';
import 'package:recap/ui/screens/searched_products_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List ScreensList = [
    HomeScreen(),
    CartScreen(),
    FavouritesScreen(),
    MenuScreen(),
  ];

  List ColorsList = [
    Color.fromARGB(255, 214, 214, 75),
    Colors.purple,
    Colors.redAccent,
    Colors.blueAccent,
  ];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ScreensList[_selectedIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                )
              ],
              borderRadius: BorderRadius.circular(15)),
          child: GNav(
            // rippleColor: Colors.white, // tab button ripple color when pressed
            // hoverColor: Colors.white, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(
                color: ColorsList[_selectedIndex],
                width: 2), // tab button border
            // tabBorder:
            //     Border.all(color: Colors.grey, width: 1), // tab button border
            tabShadow: [
              BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 8)
            ], // tab button shadow
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 400), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor:
                ColorsList[_selectedIndex], // selected icon and text color
            iconSize: 30, // tab button icon size
            tabBackgroundColor: ColorsList[_selectedIndex]
                .withOpacity(0.1), // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.shopping_cart_outlined,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.favorite_outline,
                text: 'Favourites',
              ),
              GButton(
                icon: Icons.menu,
                text: 'Menu',
              )
            ],
          ),
        ));
  }
}
