import 'package:recap/providers/ProductsProviders/ProductRepository.dart';

import '../../httpServices/ProductServices/ProductApi.dart';
import '../../models/productModel.dart';
import '../../shared_preferences.dart';

class ProductAdder {
  addProduct(ProductModel product) async {
    String userId = await ShopSharedPreferences().userId;
    String idToken = await ShopSharedPreferences().idToken;
    ProductApi prod = ProductApi(idToken);
    await prod.addProduct(product, userId);
    ProductRepository productRepository = ProductRepository();
    productRepository.getProducts();
  }
}
