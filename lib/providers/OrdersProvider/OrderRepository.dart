import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:recap/models/orderModel.dart';
import 'package:recap/providers/OrdersProvider/OrderAdder.dart';
import 'package:recap/providers/OrdersProvider/OrderFetcher.dart';

import '../../httpServices/OrderServices/OrderAdderApi.dart';
import '../../shared_preferences.dart';

class OrderRepository with ChangeNotifier {
  List<OrderModel> _orders = [];

  set orders(List<OrderModel> value) {
    _orders = value;
  }

  List<OrderModel> get orders {
    return _orders;
  }

  Future<void> getOrders() async {
  OrderFetcher orderFetcher = OrderFetcher();
  orderFetcher.fetchOrders();
  notifyListeners();
  }

 Future<void> addOrder(OrderModel order) async{
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    OrderAdderApi orderAdderApi = OrderAdderApi();
    orderAdderApi.addOrder(order, idToken, userId);
    getOrders();
 }  
}
