import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:recap/models/cartItemModel.dart';
import 'package:recap/models/productModel.dart';

class CartRepository with ChangeNotifier {
  Map<String, CartItemModel> _cart = {};

  set cart(Map<String, CartItemModel> value) {
    _cart = value;
  }

  Map<String, CartItemModel> get cart {
    return _cart;
  }

  int get cartLength {
    return _cart.length;
  }

  void addItem(ProductModel product) {
    if (cart.containsKey(product.id)) {
      cart.update(
          product.id!,
          (cartItem) => CartItemModel(
              id: cartItem.id,
              category: cartItem.category,
              title: cartItem.title,
              description: cartItem.description,
              price: cartItem.price,
              imageUrl: cartItem.imageUrl,
              quantity: cartItem.quantity + 1));
    } else {
      cart.putIfAbsent(
          product.id!,
          () => CartItemModel(
              id: product.id!,
              category: product.category,
              title: product.title,
              description: product.description,
              price: product.price,
              imageUrl: product.imageUrl,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    cart.remove(productId);
    notifyListeners();
  }


  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}
