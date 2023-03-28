import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/OrdersProvider/OrderRepository.dart';
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
    context.read<OrderRepository>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Provider.of<OrderRepository>(context).orders.isNotEmpty
              ? ListView.builder(
                  itemCount: Provider.of<OrderRepository>(context).orders.length,
                  itemBuilder: (context, index) {
                    return OrderTileWidget(
                        orderModel:
                            Provider.of<OrderRepository>(context).orders[index]);
                  })
              : Center(
                  child: Text('There Is No Orders',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w100)),
                )),
    );
  }
}
