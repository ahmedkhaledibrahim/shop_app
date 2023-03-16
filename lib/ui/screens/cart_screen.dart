import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recap/models/cartItemModel.dart';
import 'package:recap/models/orderModel.dart';
import 'package:recap/providers/ordersProvider.dart';
import 'package:recap/services/payments.dart';

import '../../providers/cartProvider.dart';
import '../widgets/cart_tile_widget.dart';
import '../widgets/product_tile_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItemModel> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Provider.of<CartProvider>(context).cart.isNotEmpty
              ? ListView.builder(
                  itemCount: Provider.of<CartProvider>(context).cart.length,
                  itemBuilder: (context, index) {
                    List<CartItemModel> cartItems = [];
                    Provider.of<CartProvider>(context).cart.forEach(
                          (key, value) => cartItems.add(CartItemModel(
                              id: value.id,
                              category: value.category,
                              title: value.title,
                              description: value.description,
                              price: value.price,
                              imageUrl: value.imageUrl,
                              quantity: value.quantity)),
                        );
                    items = cartItems;
                    return CartTileWidget(cart: cartItems[index]);
                  })
              : Center(
                  child: Text('Your Cart Is Empty',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w100)),
                )),
      floatingActionButton: Provider.of<CartProvider>(context).cart.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                double orderPrice = getOrderPrice(context);
                // print('5');
                // PaymentController().makePayment(
                //     amount: '5', currency: 'USD');
                OrderModel order = OrderModel(
                    price: orderPrice,
                    products: items,
                    amount: items.length,
                    date: DateTime.now().toString());
                Provider.of<OrdersProvider>(context,listen: false).addOrder(order);
                  Get.snackbar(
                                "My Shop",
                                "The Order Have Been Added Successfully",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Color.fromARGB(255, 5, 14, 86),
                                icon: Icon(Icons.done, color: Colors.white),
                                borderRadius: 20,
                                margin: EdgeInsets.all(15),
                                colorText: Colors.white,
                                duration: Duration(seconds: 5),
                                isDismissible: true,
                                forwardAnimationCurve: Curves.easeOutBack,
                              );
                  Provider.of<CartProvider>(context,listen: false).clearCart();
              },
              child: Icon(Icons.done, color: Colors.white),
              backgroundColor: Color.fromARGB(255, 14, 1, 88),
            )
          : const SizedBox(height: 0),
    );
  }

  double getOrderPrice(BuildContext context) {
    double orderPrice = 0.0;

    for (var item in items) {
      orderPrice = orderPrice + (item.price * item.quantity);
    }
    return orderPrice;
  }
}
