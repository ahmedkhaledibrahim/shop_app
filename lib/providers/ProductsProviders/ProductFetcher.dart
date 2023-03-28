
import 'package:recap/providers/ProductsProviders/ProductRepository.dart';

import '../../httpServices/ProductServices/ProductApi.dart';
import '../../shared_preferences.dart';

class ProductFetcher{
  Future<void> fetchProducts() async {
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    ProductApi prod = ProductApi(idToken);
    ProductRepository productRepository = ProductRepository();
    productRepository.products = await prod.fetchProducts(userId);

  }

  void fetchUserProducts() async {
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    ProductApi prod = ProductApi(idToken);
    ProductRepository productRepository = ProductRepository();
    productRepository.userProducts = await prod.fetchUserProducts(userId);

  }
}
