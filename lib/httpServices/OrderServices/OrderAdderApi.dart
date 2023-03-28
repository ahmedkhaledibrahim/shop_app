import 'dart:convert';

import '../../models/orderModel.dart';
import 'package:http/http.dart' as http;

class OrderAdderApi {
  Future<void> addOrder(
      OrderModel order, String authToken, String userId) async {
    var url =
        'https://my-shop-8033c-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

    try {
      await http.post(Uri.parse(url),
          body: jsonEncode({
            'amount': order.amount,
            'date': order.date,
            'price': order.price,
            'products': order.products
                .map((cartItem) => {
                      'id': cartItem.id,
                      'title': cartItem.title,
                      'category': cartItem.category,
                      'description': cartItem.description,
                      'imageUrl': cartItem.imageUrl,
                      'quantity': cartItem.quantity,
                      'price': cartItem.price,
                    })
                .toList()
          }));
    } catch (e) {}
  }
}
