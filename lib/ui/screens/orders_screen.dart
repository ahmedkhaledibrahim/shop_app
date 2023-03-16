import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/ordersProvider.dart';
import 'package:recap/ui/widgets/order_tile_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrdersProvider>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Provider.of<OrdersProvider>(context).orders.isNotEmpty
              ? ListView.builder(
                  itemCount: Provider.of<OrdersProvider>(context).orders.length,
                  itemBuilder: (context, index) {
                    return OrderTileWidget(
                        orderModel:
                            Provider.of<OrdersProvider>(context).orders[index]);
                  })
              : Center(
                  child: Text('There Is No Orders',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w100)),
                )),
    );
  }
}
