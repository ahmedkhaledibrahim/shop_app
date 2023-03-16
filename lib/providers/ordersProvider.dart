import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:recap/httpServices/orders.dart';
import 'package:recap/models/orderModel.dart';

import '../shared_preferences.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return _orders;
  }

  Future<void> getOrders() async {
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    _orders = await Orders().fetchOrders(idToken, userId);
    notifyListeners();
  }

 Future<void> addOrder(OrderModel order) async{
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    Orders().addOrder(order, idToken, userId);
    getOrders();
 }  
}
