import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/productsProvider.dart';
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
    Provider.of<ProductsProvider>(context, listen: false).getUserProducts();
   
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
                  Provider.of<ProductsProvider>(context).userProducts.length,
              itemBuilder: (context, index) {
                return ProductTileWidget(
                    productModel: Provider.of<ProductsProvider>(context)
                        .userProducts[index],isUserProduct: true,);
              })),
    );
  }
}
