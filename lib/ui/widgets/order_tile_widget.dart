import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recap/models/orderModel.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

class OrderTileWidget extends StatefulWidget {
  const OrderTileWidget({Key? key, required this.orderModel}) : super(key: key);
  final OrderModel orderModel;

  @override
  State<OrderTileWidget> createState() => _OrderTileWidgetState();
}

class _OrderTileWidgetState extends State<OrderTileWidget>
    with SingleTickerProviderStateMixin {
  double height = 70;
  bool isShowed = false;
  late AnimationController _iconController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _iconController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _iconController.dispose();
  }

  Future<bool> _showOrder() async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  toggleShowOrder() {
    setState(() {
      isShowed = !isShowed;
      isShowed ? _iconController.forward() : _iconController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isShowed
          ? MediaQuery.of(context).size.height * 0.3
          : MediaQuery.of(context).size.height * 0.108,
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
      duration: Duration(seconds: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${DateFormat.yMEd().format(DateTime.parse(widget.orderModel.date))}',
                style: TextStyle(
                    color: Color.fromARGB(192, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
              Text(
                '\$${widget.orderModel.price}',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 114, 10),
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
              IconButton(
                  onPressed: () {
                    toggleShowOrder();
                  },
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _iconController,
                    color: Color.fromARGB(192, 0, 0, 0),
                  ))
            ],
          ),
          AnimatedOpacity(
            opacity: isShowed ? 1 : 0,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Divider(
              color: Colors.grey,
              endIndent: 5,
              indent: 5,
            ),
          ),
          isShowed
              ? FutureBuilder(
                  future: _showOrder(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.orderModel.products.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(-1, 0),
                                          color: Colors.grey,
                                          blurRadius: 2),
                                    ]),
                                child: Row(
                                  children: [
                                    Image.network(
                                      widget
                                          .orderModel.products[index].imageUrl,
                                      fit: BoxFit.contain,
                                      width: 200,
                                      height: 100,
                                    ),
                                    VerticalDivider(
                                        color: Color.fromARGB(255, 59, 53, 53),
                                        endIndent: 5,
                                        indent: 5,
                                        thickness: 0.7),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          widget
                                              .orderModel.products[index].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          '\$${widget.orderModel.products[index].price}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 0, 114, 10)),
                                        ),
                                        Text(
                                          '\Quantity : ${widget.orderModel.products[index].quantity}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 75, 85, 76)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                  })
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
