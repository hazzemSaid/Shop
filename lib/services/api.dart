import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';
import '/constant/constant.dart';

class API_call {
  Future<List<Product>> getProducts() async {
    dynamic response =
        await http.get(Uri.parse('${Constant.baseUrl}/products'));
    if (response.statusCode == 200) {
      List<Product> products = [];
      for (var item in json.decode(response.body)) {
        if (item['images'][0].endsWith('/any')) continue;
        products.add(Product.fromJson(item));
      }
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getproduct_byid(int id) async {
    dynamic response =
        await http.get(Uri.parse('${Constant.baseUrl}/products/$id'));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
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
}
