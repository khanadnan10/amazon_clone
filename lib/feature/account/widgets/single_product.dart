import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10.0),
        child: Image.network(
          image,
          fit: BoxFit.fitHeight,
          width: 180.0,
        ),
      ),
    );
  }
}
