import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:recap/models/productModel.dart';

 class Products {


  Future<List<ProductModel>> fetchProducts(
      String authToken, String userId) async {
    var url =
        'https://my-shop-8033c-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    var favouriteProdsUrl =
        'https://my-shop-8033c-default-rtdb.firebaseio.com/favourites/$userId.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;

      // final favResponse = await http.get(Uri.parse(favouriteProdsUrl));
      // final favExtractedData =
      //     jsonDecode(favResponse.body) as Map<String, dynamic>;

      final List<ProductModel> loadedProducts = [];
      if (extractedData.isNotEmpty) {
        extractedData.forEach((productId, productData) {
          loadedProducts.add(ProductModel(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              price: productData['price'],
              category: productData['category'],
              isFavourite: false,
              imageUrl: productData['imageUrl']));
        });
        return loadedProducts;
      }
      print("fetch ${loadedProducts.length}");
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<ProductModel>> fetchUserProducts(
      String authToken, String userId) async {
    String filtrationurl = 'orderBy="creatorId"&equalTo="$userId"';
    var url =
        'https://my-shop-8033c-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filtrationurl';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<ProductModel> loadedProducts = [];
      if (extractedData.isNotEmpty) {
        extractedData.forEach((productId, productData) {
          loadedProducts.add(ProductModel(
              id: productId,
              category: productData['category'],
              title: productData['title'],
              description: productData['description'],
              price: productData['price'],
              isFavourite: productData['isFavourite'],
              imageUrl: productData['imageUrl']));
        });
        return loadedProducts;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(
      ProductModel product, String userId, String authToken) async {
    var url =
        'https://my-shop-8033c-default-rtdb.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
            'category': product.category,
            'isFavourite': false,
          }));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleProductFavourite(
      ProductModel product, String userId, String authToken) async {
    var url =
        'https://my-shop-8033c-default-rtdb.firebaseio.com/favourites/$userId/${product.id}.json?auth=$authToken';
    try {
      final response =
          http.put(Uri.parse(url), body: jsonEncode(product.isFavourite));
    } catch (e) {
      rethrow;
    }
  }
}
