import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recap/models/productModel.dart';
import 'package:recap/providers/ProductsProviders/ProductRepository.dart';

import 'package:recap/ui/screens/searched_products_screen.dart';

import '../widgets/product_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> duplicateProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductRepository>(context, listen: false).getProducts();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.builder(
            itemCount: Provider.of<ProductRepository>(context).products.length,
            itemBuilder: (context, index) {
              return ProductTileWidget(
                productModel:
                    Provider.of<ProductRepository>(context).products[index],
                isUserProduct: false,
              );
            }));
  }
}
