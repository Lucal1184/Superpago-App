import 'package:flutter/material.dart';

class ShowPrice extends StatelessWidget {
  final double totalPrice;

  const ShowPrice({Key? key, required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          totalPrice.toStringAsFixed(2).toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        )
      ],
    );
  }
}
