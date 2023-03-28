import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../httpServices/ProductServices/ProductApi.dart';
import '../httpServices/ProductServices/ProductFavouriteApi.dart';
import '../models/productModel.dart';
import '../shared_preferences.dart';

class FavouriteRepository with ChangeNotifier{
  List<ProductModel> _favouriteProducts = [];

  set favouriteProducts(List<ProductModel> value) {
    _favouriteProducts = value;
  }

  List<ProductModel> get favouriteProducts {
    return [..._favouriteProducts];
  }

  Future<void> toggleFavouriteProduct(ProductModel product) async {
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    bool favStat = product.isFavourite!;
    product.isFavourite = !favStat;
    ProductFavouriteApi prod = ProductFavouriteApi(idToken);
    prod.toggleProductFavourite(product, userId);
    notifyListeners();
  }

  ProductModel getFavouriteProductById(String id) {
    return favouriteProducts.firstWhere((element) => element.id == id);
  }

  Future<void> getFavouriteProducts() async {
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    ProductApi prod = ProductApi(idToken);
    List<ProductModel> allProducts = await prod.fetchProducts(userId);
    favouriteProducts = allProducts.where((product) => product.isFavourite == true).toList();
    notifyListeners();
  }
}