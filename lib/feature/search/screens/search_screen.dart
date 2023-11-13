// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/admin/model/product.dart';
import 'package:amazon_clone/feature/home/services/search_services.dart';
import 'package:amazon_clone/feature/home/widgets/address_box.dart';
import 'package:amazon_clone/feature/search/widgets/searched_product.dart';
import 'package:flutter/material.dart';

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
  List<Product>? productList = [];
  void fetchSearchProductItems() async {
    productList = await searchServices.fetchCategoryProducts(
      context: context,
      searchQuery: widget.searchQuery,
    );

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    fetchSearchProductItems();
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
                      onFieldSubmitted: (value) => Navigator.pushNamed(
                        context,
                        SearchScreen.routeName,
                        arguments: value,
                      ),
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
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      return SearchedProduct(
                        product: productList![index],
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
