import 'package:recap/models/cartItemModel.dart';

class OrderModel {
  String? id;
  final List<CartItemModel> products;
  final double price;
  final String date;
  final int amount;

  OrderModel({
    this.id,
    required this.price,
    required this.products,
    required this.amount,
    required this.date,
  });
}
