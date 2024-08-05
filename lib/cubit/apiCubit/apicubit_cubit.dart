import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shop/constant/constant.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/AllCategory.dart';
import 'package:shop/screens/product_item.dart';

import '/services/api.dart';
import '../../models/category.dart';

part 'apicubit_state.dart';

class ApiCubit extends Cubit<ApicubitState> {
  List<Product> data = [];
  Product? item;
  List<Categoryes> ALLCategoryes = [];
  ApiCubit() : super(ApicubitInitial()) {}
  //get all product
  //steam

  Future<void> getAllProduct() async {
    emit(ApicubitLoading());
    try {
      this.data = await API_call().getProducts();
      emit(ApicubitSuccess_allProdcut(data));
    } catch (e) {
      emit(ApicubitError_allProdcut(e.toString()));
    }
  }

  //get single product
  Future<void> getSingleProduct(int id) async {
    print(id);
    emit(ApicubitLoading());
    print('loading');
    try {
      print('try single product');
      final response =
          await http.get(Uri.parse('${Constant.baseUrl}/products/$id'));
      print('response');

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Convert the JSON map to a Product object
        this.item = Product.fromJson(jsonResponse);
        print('success single product');
        // Emit success state with the Product object
        emit(ApicubitSuccess_singleProdcut(item!));
      } else {
        // Handle response error
        print('failed single product');
        emit(ApicubitError_singleProdcut('Failed to load product'));
      }
    } catch (e) {
      print('failed single product $e');
      emit(ApicubitError_singleProdcut(e.toString()));
    }
  }

  //get all category
  Future<void> getAllCategory() async {
    emit(ApicubitLoading());
    try {
      ALLCategoryes = await API_call().getCategories();
      emit(ApicubitSuccess_allCategory(ALLCategoryes));
    } catch (e) {
      emit(ApicubitError_allCategory(e.toString()));
    }
  }

  //singal category
  Future<void> getSingleCategory(int id) async {
    emit(ApicubitLoading());
    try {
      final data = await API_call().getCategoryById(id);
      emit(ApicubitSuccess_singleCategory(data));
    } catch (e) {
      emit(ApicubitError_singleCategory(e.toString()));
    }
  }
}
