import 'package:flutter/material.dart';

extension MySize on int {
  SizedBox get h => SizedBox(
        height: toDouble(),
      );
  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}

extension textFie on String {
// late String tfH;
  TextField get tf => TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "41",
        ),
      );
}
