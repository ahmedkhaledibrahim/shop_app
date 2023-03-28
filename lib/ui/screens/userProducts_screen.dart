import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/ProductsProviders/ProductRepository.dart';

import 'package:recap/ui/widgets/product_tile_widget.dart';

class UserProductsScreen extends StatefulWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductRepository>(context, listen: false).getUserProducts();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount:
                  Provider.of<ProductRepository>(context).userProducts.length,
              itemBuilder: (context, index) {
                return ProductTileWidget(
                    productModel: Provider.of<ProductRepository>(context)
                        .userProducts[index],isUserProduct: true,);
              })),
    );
  }
}
