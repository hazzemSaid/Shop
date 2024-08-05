import 'package:flutter/material.dart';

class fild extends StatelessWidget {
  final String type;
  Function(String)? onchanged;
  fild({required this.type, required this.onchanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter some text';
          } else if (value.length < 10) {
            return 'Please enter more than 10 characters';
          }
          return null;
        },
        onChanged: onchanged,
        decoration: InputDecoration(
          label: Text('$type'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
