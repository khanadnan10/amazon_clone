// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/feature/admin/model/product.dart';

class SearchedProduct extends StatelessWidget {
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
            height: 135.0,
            width: 135.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16.0,
              ),
              maxLines: 2,
            ),
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: const Stars(rating: 4.0),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "\$${product.price.toInt()}",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: const Text(
                "Eligible for Free Shipping",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: const Text(
                "In Stock",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
