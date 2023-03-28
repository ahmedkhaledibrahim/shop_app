import 'dart:convert';

import '../../models/productModel.dart';
import 'package:http/http.dart' as http;

class ProductFavouriteApi {
  final String authToken;

  ProductFavouriteApi(this.authToken);

  Future<void> toggleProductFavourite(
      ProductModel product, String userId) async {
    var url =
        'https://my-shop-8033c-default-rtdb.firebaseio.com/favourites/$userId/${product.id}.json?auth=${this.authToken}';
    try {
      final response =
          http.put(Uri.parse(url), body: jsonEncode(product.isFavourite));
    } catch (e) {
      rethrow;
    }
  }
}
