import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/FavouriteRepository.dart';
import 'package:recap/providers/CartProviders/CartRepository.dart';


import '../../models/productModel.dart';

class ProductTileWidget extends StatefulWidget {
  const ProductTileWidget(
      {Key? key, required this.productModel, required this.isUserProduct})
      : super(key: key);
  final ProductModel productModel;
  final bool isUserProduct;

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool favStat = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favStat = widget.productModel.isFavourite!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.white),
          //width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Text(
                '${widget.productModel.title}',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${widget.productModel.description}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '\$${widget.productModel.price}',
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
                    '${widget.productModel.imageUrl}',
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.9,
                  ),
                  !widget.isUserProduct
                      ? Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: 200,
                          child: FloatingActionButton(
                            backgroundColor: Color.fromARGB(137, 39, 199, 33),
                            onPressed: () {
                              Provider.of<CartRepository>(context, listen: false)
                                  .addItem(widget.productModel);
                              Get.snackbar(
                                "My Shop",
                                "You Have Added ${widget.productModel.title} To Cart",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.lightGreen,
                                icon: Icon(Icons.shopping_cart_outlined,
                                    color: Colors.white),
                                borderRadius: 20,
                                margin: EdgeInsets.all(15),
                                colorText: Colors.white,
                                duration: Duration(seconds: 5),
                                isDismissible: true,
                                forwardAnimationCurve: Curves.easeOutBack,
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Text(
                              'ADD TO CART',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                      : SizedBox(
                          height: 0,
                        ),
                ],
              )
            ],
          ),
        ),
        widget.isUserProduct
            ? const SizedBox(
                height: 0,
              )
            : Container(
                margin: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () {
                    Provider.of<FavouriteRepository>(context, listen: false)
                        .toggleFavouriteProduct(widget.productModel);
                    setState(() {
                      favStat = !favStat;
                    });
                    Get.snackbar(
                      "My Shop",
                      favStat
                          ? "You Have Added ${widget.productModel.title} To Favourites"
                          : "You Have Deleted ${widget.productModel.title} From Favourites",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      icon: Icon(Icons.favorite_outlined, color: Colors.white),
                      borderRadius: 20,
                      margin: EdgeInsets.all(15),
                      colorText: Colors.white,
                      duration: Duration(seconds: 5),
                      isDismissible: true,
                      forwardAnimationCurve: Curves.easeOutBack,
                    );
                  },
                  icon: favStat
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_outline),
                  color: Colors.red.shade600,
                  iconSize: 30,
                ))
      ],
    );
  }
}
