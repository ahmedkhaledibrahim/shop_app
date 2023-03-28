import 'package:flutter/cupertino.dart';
import 'package:recap/providers/CartProviders/CartRepository.dart';

import '../../models/cartItemModel.dart';

class QuantityDecreaser with ChangeNotifier{
  void decreaseQuantity(String productId) {
    CartRepository cartProvider = CartRepository();

    if (!cartProvider.cart.containsKey(productId)) {
      return;
    } else if (cartProvider.cart[productId]!.quantity > 1) {
      cartProvider.cart.update(
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
      cartProvider.removeItem(productId);
    }
  }
}