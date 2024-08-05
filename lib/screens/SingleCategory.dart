import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/cubit/apiCubit/apicubit_cubit.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/product_item.dart';

class SingleCategory extends StatelessWidget {
  final String? singleCategory;
  SingleCategory({this.singleCategory});
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiCubit, ApicubitState>(
      listener: (context, state) {
        if (state is ApicubitError_allProdcut) {
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
        if (state is ApicubitLoading) {
          loading = true;
        } else {
          loading = false;
        }
      },
      builder: (context, state) {
        List<Product> data = BlocProvider.of<ApiCubit>(context).data;
        print(state);
        if (state is ApicubitSuccess_allProdcut) {
          data = state.data.where((element) {
            return element.category == singleCategory;
          }).toList();
        }

        return ModalProgressHUD(
          inAsyncCall: loading,
          child: Scaffold(
            appBar: AppBar(
              title: Text('All items for $singleCategory'),
            ),
            body: data == null
                ? Center(child: Text('No data available'))
                : GridView.builder(
                    itemCount: min(data!.length, 15),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, indx) {
                      final product = data![indx];
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<ApiCubit>(context)
                              .getSingleProduct(product.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => product_item(),
                            ),
                          ).whenComplete(() {
                            BlocProvider.of<ApiCubit>(context)
                                .getSingleProduct(product.id);
                            BlocProvider.of<ApiCubit>(context).item = null;
                          });
                        },
                        child: Card(
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.network(
                                  product.images[0],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
