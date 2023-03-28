import 'package:recap/httpServices/OrderServices/OrderAdderApi.dart';
import 'package:recap/providers/OrdersProvider/OrderRepository.dart';
import '../../models/orderModel.dart';
import '../../shared_preferences.dart';

class OrderAdder{
  Future<void> addOrder(OrderModel order) async{
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    OrderAdderApi orderAdderApi = OrderAdderApi();
    orderAdderApi.addOrder(order, idToken, userId);
    OrderRepository orderRepository = OrderRepository();
    orderRepository.getOrders();
  }
}