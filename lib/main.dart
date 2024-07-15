import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/api.dart';

Product? products;
void main() async {
  products = await API_call().getproduct_byid(10);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: min(5, 40),
          itemBuilder: (context, indx) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(products!.title),
                subtitle: Text(products!.id.toString()),
                leading: Image.network(products!.images[0]),
              ),
            );
          },
        ),
      ),
    );
  }
}
