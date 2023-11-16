// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/feature/product_details/services/product_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/admin/model/product.dart';
import 'package:amazon_clone/feature/search/screens/search_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-detail-screen';
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductServices productServices = ProductServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    if (mounted) fetchRating();
    super.initState();
  }

  void fetchRating() {
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((e) {
                return Image.network(
                  e,
                  fit: BoxFit.contain,
                  height: 250,
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 250,
                scrollPhysics: const BouncingScrollPhysics(),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "\$${widget.product.price}",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: 0),
              child: Text(
                widget.product.description,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onPressed: () {},
                text: 'Buy Now',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Add to cart',
                color: Colors.yellow[600],
                onPressed: () {},
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Rating',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RatingBar.builder(
                  initialRating: myRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: GlobalVariables.secondaryColor,
                  ),
                  onRatingUpdate: (rating) {
                    productServices.rateProduct(
                      context: context,
                      product: widget.product,
                      rating: rating,
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
