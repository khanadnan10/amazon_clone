import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feature/home/widgets/address_box.dart';
import 'package:amazon_clone/feature/home/widgets/carousel_image.dart';
import 'package:amazon_clone/feature/home/widgets/deal_of_the_day.dart';
import 'package:amazon_clone/feature/home/widgets/top_categories.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            AddressBox(),
            SizedBox(height: 10.0),
            TopCategories(),
            SizedBox(height: 10.0),
            CarouselImage(),
            SizedBox(height: 10.0),
            DealOfTheDay(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
