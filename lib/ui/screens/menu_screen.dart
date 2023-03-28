import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/ProductsProviders/ProductRepository.dart';

import 'package:recap/shared_preferences.dart';
import 'package:recap/ui/screens/addProduct_screen.dart';
import 'package:recap/ui/screens/authentication_screen.dart';
import 'package:recap/ui/screens/orders_screen.dart';
import 'package:recap/ui/screens/userProducts_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                  child: Text(
                'My Shop',
                style: TextStyle(
                    fontFamily: 'Anton', fontSize: 45, color: Colors.white),
              )),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 180, 83, 54),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 8, color: Colors.grey, offset: Offset(0, 2))
                  ])),
          InkWell(
            onTap: () => Get.to(() => AddProductScreen()),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.shopping_bag,
                    color: Color.fromARGB(255, 175, 92, 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Add Product",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 28, 27, 27))),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
          ),
          InkWell(
            onTap: () => Get.to(()=> OrdersScreen()),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.wallet,
                    color: Color.fromARGB(255, 6, 99, 128),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("My Orders",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 28, 27, 27))),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
          ),
          InkWell(
            onTap: () => Get.to(UserProductsScreen()),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 6, 128, 14),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("My Products",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 28, 27, 27))),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
          ),
          InkWell(
            onTap: () {
              context.read<ProductRepository>().destroyProductsList();
              ShopSharedPreferences().autoLogOut();
              Get.offAll(() => AuthenticationScreen());
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 81, 0, 0),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Logout",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 96, 1, 1))),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
