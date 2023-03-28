import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recap/models/cartItemModel.dart';
import 'package:recap/models/productModel.dart';
import 'package:recap/providers/CartProviders/QuantityDecreaser.dart';
import 'package:recap/providers/CartProviders/CartRepository.dart';

class CartTileWidget extends StatefulWidget {
  const CartTileWidget({Key? key, required this.cart}) : super(key: key);
  final CartItemModel cart;

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white),
      //width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Text(
            '${widget.cart.title}',
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${widget.cart.description}',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w300, color: Colors.grey),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '\$${widget.cart.price}',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 114, 10)),
          ),
          const SizedBox(
            height: 5,
          ),
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image.network(
                '${widget.cart.imageUrl}',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.height * 0.9,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  color: Color.fromARGB(194, 130, 130, 130),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<CartRepository>(context, listen: false).addItem(
                            ProductModel(
                                category: widget.cart.category,
                                id: widget.cart.id,
                                title: widget.cart.title,
                                description: widget.cart.description,
                                price: widget.cart.price,
                                imageUrl: widget.cart.imageUrl));
                      },
                      icon: Icon(
                        Icons.add,
                      ),
                      iconSize: 30,
                      color: Color.fromARGB(255, 55, 200, 89),
                    ),
                    Text(
                      '${widget.cart.quantity}',
                      style: TextStyle(fontSize: 25,color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<QuantityDecreaser>(context, listen: false)
                            .decreaseQuantity(widget.cart.id);
                      },
                      icon: Icon(
                        Icons.remove,
                      ),
                      iconSize: 30,
                      color: Color.fromARGB(255, 207, 58, 58),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
