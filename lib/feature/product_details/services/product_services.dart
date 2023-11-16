import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/feature/admin/model/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  void rateProduct({
    required BuildContext context,
    required double rating,
    required Product product,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
        body: jsonEncode({
          "id": product.id,
          "rating": rating,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
