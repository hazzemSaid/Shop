import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/models/category.dart';
import 'package:shop/models/product.dart';

import '/constant/constant.dart';

class API_call {
  Future<List<Product>> getProducts() async {
    dynamic response =
        await http.get(Uri.parse('${Constant.baseUrl}/products'));
    if (response.statusCode == 200) {
      List<Product> products = [];
      for (var item in json.decode(response.body)) {
        products.add(Product.fromJson(item));
      }
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  /*{
    "title": "New Product",
    "price": 10,
    "description": "A description",
    "categoryId": 1,
    "images": [
        "https://placeimg.com/640/480/any"
    ]
}*/
  Future<Product> create({
    required String title,
    required int price,
    required String description,
    required int categoryId,
    required String image,
  }) async {
    final url = Uri.parse('${Constant.baseUrl}/products');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'price': price,
        'description': description,
        'categoryId': categoryId,
        'images': [
          image,
        ],
      }),
    );
    print('success');
    return Product.fromJson(json.decode(response.body));
  }

  Future<bool> deletProduct(int id) async {
    final url = Uri.parse('${Constant.baseUrl}/products/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<bool> updateProduct({
    required int id,
    required String title,
    required int price,
    required String description,
    required int categoryId,
    required String image,
  }) async {
//https://api.escuelajs.co/api/v1/products/:id
    final url = Uri.parse('${Constant.baseUrl}/products/$id');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'price': price,
        'description': description,
        'categoryId': categoryId,
        'images': [
          image,
        ],
      }),
    );
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

/*https://api.escuelajs.co/api/v1/categories*/
  Future<List<Categoryes>> getCategories() async {
    dynamic response =
        await http.get(Uri.parse('${Constant.baseUrl}/categories'));
    if (response.statusCode == 200) {
      List<Categoryes> categories = [];
      for (var item in json.decode(response.body)) {
        categories.add(Categoryes.fromJson(item));
      }
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  //https://api.escuelajs.co/api/v1/categories/:id
  Future<Categoryes> getCategoryById(int id) async {
    dynamic response =
        await http.get(Uri.parse('${Constant.baseUrl}/categories/$id'));
    if (response.statusCode == 200) {
      return Categoryes.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load categories');
    }
  }

  /*  "name": "hazem category",
    "image": "https://placeimg.com/640/480/1919"
    */
  Future<void> UpdateCategory({required int id, required String name}) async {
    final url = Uri.parse('${Constant.baseUrl}/categories/$id');
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': 'hazem category',
        }),
      );
      print('success');
    } on Exception catch (e) {
      print(e);
      // TODO
    }
    return;
  }

  Future<void> createCategory(
      {required String name, required String image}) async {
    try {
      var url = Uri.parse("https://api.escuelajs.co/api/v1/categories/");
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'image': image,
        }),
      );
      print('success');
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> deleteCategory(int id) async {
    final url = Uri.parse('${Constant.baseUrl}/categories/$id');
    final response = await http.delete(url);
  }
}
