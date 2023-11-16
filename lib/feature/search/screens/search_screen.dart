import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/product_details/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/feature/admin/model/product.dart';
import 'package:amazon_clone/feature/home/services/search_services.dart';
import 'package:amazon_clone/feature/home/widgets/address_box.dart';
import 'package:amazon_clone/feature/search/widgets/searched_product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';

  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  final String searchQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchServices = SearchServices();
  List<Product>? productList;

  Future<List<Product>?> fetchSearchProductItems() async {
    return await searchServices.fetchCategoryProducts(
      context: context,
      searchQuery: widget.searchQuery,
    );
  }

  @override
  void initState() {
    fetchSearchProductItems().then((products) {
      setState(() {
        productList = products;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42.0,
                    margin: const EdgeInsets.only(left: 15.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(7.0),
                      elevation: 1,
                      child: TextFormField(
                        controller:
                            TextEditingController(text: widget.searchQuery),
                        onFieldSubmitted: (value) {
                          value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Amazon.in',
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.only(top: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black38,
                            ),
                          ),
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6.0),
                              child: Icon(
                                Icons.search,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 42.0,
                  margin: const EdgeInsets.only(left: 7),
                  child: const Icon(Icons.mic),
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder<List<Product>?>(
            future: fetchSearchProductItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final products = snapshot.data!;
                return Column(
                  children: [
                    const AddressBox(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              ProductDetailsScreen.routeName,
                              arguments: products[index],
                            ),
                            child: SearchedProduct(
                              product: products[index],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Loader();
              }
            }));
  }
}
