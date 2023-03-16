import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/productsProvider.dart';

import '../widgets/product_tile_widget.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Provider.of<ProductsProvider>(context)
                  .favouriteProducts
                  .isNotEmpty
              ? ListView.builder(
                  itemCount:
                      Provider.of<ProductsProvider>(context).favouriteProducts.length,
                  itemBuilder: (context, index) {
                    
                    return ProductTileWidget(
                      productModel: Provider.of<ProductsProvider>(context)
                          .favouriteProducts[index],
                      isUserProduct: false,
                    );
                  })
              : Center(
                  child: Text(
                  "No Favourite Products",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w100),
                ))),
    );
  }
}
