import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/cubit/apiCubit/apicubit_cubit.dart';

import 'SingleCategory.dart';

class AllCategory extends StatelessWidget {
  @override
  bool loading = false;
  Widget build(BuildContext context) {
    return BlocConsumer<ApiCubit, ApicubitState>(
      listener: (context, state) {
        if (state is ApicubitError_allCategory) {
          loading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
        if (state is ApicubitSuccess_allCategory) {
          loading = false;
        }
        if (state is ApicubitLoading) {
          loading = true;
        } else {
          loading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: loading,
          child: Scaffold(
            appBar: AppBar(
              title: Text('All Category'),
            ),
            body: BlocProvider.of<ApiCubit>(context).ALLCategoryes == null
                ? Center(child: Text('No data available'))
                : GridView.builder(
                    itemCount: min(
                        BlocProvider.of<ApiCubit>(context).ALLCategoryes.length,
                        6),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, indx) {
                      var data =
                          BlocProvider.of<ApiCubit>(context).ALLCategoryes;
                      final product = data![indx];
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<ApiCubit>(context).getAllProduct();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleCategory(
                                singleCategory: product.name,
                              ),
                            ),
                          ).then(() {
                            BlocProvider.of<ApiCubit>(context).data = [];
                          } as FutureOr Function(dynamic value));
                        },
                        child: Card(
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.name,
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
