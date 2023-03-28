import 'package:recap/providers/ProductsProviders/ProductRepository.dart';

class ProductDestroyer{
  destroyProductsList() {
    ProductRepository productRepository = ProductRepository();
    productRepository.products.clear();
    productRepository.userProducts.clear();
  }
}