import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:recap/models/cartItemModel.dart';
import 'package:recap/models/productModel.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItemModel> _cart = {};

  Map<String, CartItemModel> get cart {
    return _cart;
  }

  int get cartLength {
    return _cart.length;
  }

  void addItem(ProductModel product) {
    if (_cart.containsKey(product.id)) {
      _cart.update(
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
      _cart.putIfAbsent(
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
    _cart.remove(productId);
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    if (!_cart.containsKey(productId)) {
      return;
    } else if (_cart[productId]!.quantity > 1) {
      _cart.update(
          productId,
          (cartItem) => CartItemModel(
              id: cartItem.id,
              category: cartItem.category,
              title: cartItem.title,
              description: cartItem.description,
              price: cartItem.price,
              imageUrl: cartItem.imageUrl,
              quantity: cartItem.quantity - 1));
      notifyListeners();
    } else {
      removeItem(productId);
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
