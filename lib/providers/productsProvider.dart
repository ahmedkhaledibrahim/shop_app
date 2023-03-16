import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:recap/httpServices/products.dart';
import 'package:recap/models/productModel.dart';
import 'package:recap/shared_preferences.dart';
import 'package:recap/httpServices/products.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _favouriteProducts = [];
  List<ProductModel> _userProducts = [];
  
  List<ProductModel> get products {
    return [..._products];
  }

  List<ProductModel> get userProducts {
    return [..._userProducts];
  }

  List<ProductModel> get favouriteProducts {
    return [..._favouriteProducts];
  }

  Future<void> toggleFavouriteProduct(ProductModel product) async {
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    bool favStat = product.isFavourite!;
    product.isFavourite = !favStat;
    Products().toggleProductFavourite(product, userId, idToken);
    getProducts();
  }

  ProductModel getProductById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }


  Future<void> getProducts() async {
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    _products = await Products().fetchProducts(idToken, userId);
    _favouriteProducts.clear();
    for (var prod in _products) {
        if (prod.isFavourite == true) {
          _favouriteProducts.add(prod);
        }
      }
    notifyListeners();
  }

  void getUserProducts() async {
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    _userProducts = await Products().fetchUserProducts(idToken, userId);
    notifyListeners();
  }

  addProduct(ProductModel product) async {
    String userId = await ShopSharedPreferences().userId;
    String idToken = await ShopSharedPreferences().idToken;
    await Products().addProduct(product, userId, idToken);
    getProducts();
    notifyListeners();
  }

  destroyProductsList() {
    _products.clear();
    _userProducts.clear();
  }
}
