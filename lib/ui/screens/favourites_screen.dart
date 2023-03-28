import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/FavouriteRepository.dart';
import 'package:recap/providers/ProductsProviders/ProductRepository.dart';


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
          child: Provider.of<FavouriteRepository>(context)
                  .favouriteProducts
                  .isNotEmpty
              ? ListView.builder(
                  itemCount:
                      Provider.of<FavouriteRepository>(context).favouriteProducts.length,
                  itemBuilder: (context, index) {
                    
                    return ProductTileWidget(
                      productModel: Provider.of<FavouriteRepository>(context)
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
