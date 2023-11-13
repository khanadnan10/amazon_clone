import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/common/widgets/type_def.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/feature/admin/model/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  FutureSellProduct sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      // upload image files to the cloudanry/firebase
      // get the download link of the list of images
      // upload data to the mongodb database with the provided data
      final cloudinary = CloudinaryPublic('dcspda8ue', 'idcmpdih');
      List<String> productImageUrl = [];
      for (var i in images) {
        await cloudinary
            .uploadFile(
          CloudinaryFile.fromFile(
            i.path,
            folder: name,
          ),
        )
            .then(
          (downloadUrl) {
            productImageUrl.add(downloadUrl.secureUrl);
          },
        );
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        price: price,
        images: productImageUrl,
        category: category,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
        body: product.toJson(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () => showSnackBar(context, 'Product added successfully!'),
      );
      return (success: true, message: '');
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    return (success: false, message: 'Retry... Some error occured');
  }

  // Get all the products ------------------------------------------------------
  FutureListProduct fetchProduct(BuildContext context) async {
    List<Product> productList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      // print(res.body);
      // ignore: use_build_context_synchronously
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  // Delete product --------------------------------------------------------------

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-product'),
              headers: {
                'Content-type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'id': product.id,
              }));
      // ignore: use_build_context_synchronously
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
