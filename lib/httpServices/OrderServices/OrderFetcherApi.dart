import 'dart:convert';
import 'package:recap/models/cartItemModel.dart';
import '../../models/orderModel.dart';
import 'package:http/http.dart' as http;

class OrderFetcherApi {
  Future<List<OrderModel>> fetchOrders(String authToken, String userId) async {
    var url =
        'https://my-shop-8033c-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<OrderModel> loadedOrders = [];
      if (extractedData.isNotEmpty) {
        extractedData.forEach((orderId, orderData) {
          loadedOrders.add(OrderModel(
            id: orderId,
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItemModel(
                    id: item['id'],
                    category: item['category'],
                    title: item['title'],
                    description: item['description'],
                    price: item['price'],
                    imageUrl: item['imageUrl'],
                    quantity: item['quantity']))
                .toList(),
            price: orderData['price'],
            date: orderData['date'],
          ));
        });
        return loadedOrders.reversed.toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
