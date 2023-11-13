import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/account/widgets/single_product.dart';
import 'package:amazon_clone/feature/admin/model/product.dart';
import 'package:amazon_clone/feature/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/feature/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  List<Product>? listOfProduct = [];

  void fetchAllProducts() async {
    listOfProduct = await adminServices.fetchProduct(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        setState(() {
          listOfProduct!.remove(index);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          AddProductScreen.routeName,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        tooltip: 'Add a product',
        backgroundColor: GlobalVariables.selectedNavBarColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: listOfProduct == null
          ? const Loader()
          : listOfProduct!.isEmpty
              ? const Center(
                  child: Text('No item found.'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: listOfProduct!.length,
                    itemBuilder: (context, index) {
                      final product = listOfProduct![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 140.0,
                            child: SingleProduct(
                              image: product.images.first,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              IconButton(
                                onPressed: () => deleteProduct(product, index),
                                icon: const Icon(
                                  Icons.delete_outline,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
    );
  }
}
