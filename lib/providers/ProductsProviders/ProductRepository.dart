import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:recap/providers/ProductsProviders/ProductDestroyer.dart';
import 'package:recap/providers/ProductsProviders/ProductFetcher.dart';

import '../../httpServices/ProductServices/ProductApi.dart';
import '../../models/productModel.dart';
import '../../shared_preferences.dart';

class ProductRepository with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _userProducts = [];

  set products(List<ProductModel> value) {
    _products = value;
  }

  set userProducts(List<ProductModel> value) {
    _userProducts = value;
  }

  List<ProductModel> get products {
    return [..._products];
  }

  List<ProductModel> get userProducts {
    return [..._userProducts];
  }

  Future<void> getProducts() async {
   ProductFetcher productFetcher = ProductFetcher();
   productFetcher.fetchProducts();
   notifyListeners();
  }

  void getUserProducts() async {
   ProductFetcher productFetcher = ProductFetcher();
   productFetcher.fetchUserProducts();
    notifyListeners();
  }

  addProduct(ProductModel product) async {
    String userId = await ShopSharedPreferences().userId;
    String idToken = await ShopSharedPreferences().idToken;
    ProductApi prod = ProductApi(idToken);
    await prod.addProduct(product, userId);
    getProducts();
    notifyListeners();
  }

  destroyProductsList() {
    ProductDestroyer productDestroyer = ProductDestroyer();
    productDestroyer.destroyProductsList();
  }


  }

