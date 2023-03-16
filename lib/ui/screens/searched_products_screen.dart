import 'package:flutter/material.dart';



class SearchedProductsScreen extends StatefulWidget {
  const SearchedProductsScreen({Key? key}) : super(key: key);

  @override
  State<SearchedProductsScreen> createState() => _SearchedProductsScreenState();
}

class _SearchedProductsScreenState extends State<SearchedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar()  ,
      body: Center(child: Text('search')),
    );
  }
}