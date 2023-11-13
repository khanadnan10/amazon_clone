// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/feature/admin/model/product.dart';
import 'package:amazon_clone/feature/home/services/home_services.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/constants/global_variables.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals-screen';

  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  final HomeServices homeServices = HomeServices();

  List<Product>? products = [];

  @override
  void initState() {
    // WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
    fetchCategoryProducts();
    // });
    super.initState();
  }

  void fetchCategoryProducts() async {
    products = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: products == null
          ? const Loader()
          : products!.isEmpty
              ? const Center(
                  child: Text('No Products 🗳'),
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Keep shoping for ${widget.category}',
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 170.0,
                      child: GridView.builder(
                        itemCount: products!.length,
                        padding: const EdgeInsets.only(left: 15.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1.4,
                                mainAxisSpacing: 10.0),
                        itemBuilder: (context, index) {
                          final product = products![index];
                          return Column(
                            children: [
                              SizedBox(
                                height: 130.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.network(
                                      product.images[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  right: 15.0,
                                ),
                                child: Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
