import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/feature/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final addProductFormKey = GlobalKey<FormState>();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  String selectedCategoryItem = 'Mobiles';

  List<File> productImages = [];
  void selectProductImages() async {
    List<File> image = await pickImage();
    setState(() {
      productImages = image;
    });
  }

  void sellProduct() {
    if (addProductFormKey.currentState!.validate() &&
        productImages.isNotEmpty) {
      adminServices
          .sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: selectedCategoryItem,
        images: productImages,
      )
          .then((value) {
        if (value.success) {
          Navigator.pop(context);
        } else {
          showSnackBar(context, value.message);
        }
      });
    } else {
      showSnackBar(context, 'Fill all fields');
    }
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
          centerTitle: true,
          title: const Text(
            'Add product',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
      body: Form(
        key: addProductFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                productImages.isNotEmpty
                    ? CarouselSlider(
                        items: productImages.map((e) {
                          return Image.file(
                            e,
                            fit: BoxFit.cover,
                            height: 200,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                      )
                    : GestureDetector(
                        onTap: selectProductImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10.0),
                          dashPattern: const [10, 3],
                          child: Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40.0,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[400],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  hintText: 'Product Name',
                  controller: productNameController,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  hintText: 'Description',
                  controller: descriptionController,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  hintText: 'Price',
                  keyboardType: TextInputType.number,
                  controller: priceController,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  hintText: 'Quantity',
                  keyboardType: TextInputType.number,
                  controller: quantityController,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black38,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    elevation: 0,
                    underline: const SizedBox(),
                    value: selectedCategoryItem,
                    items: GlobalVariables.categoryImages
                        .map(
                          (e) => DropdownMenuItem(
                            value: e['title']!,
                            child: Text(
                              e['title']!,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      selectedCategoryItem = value!;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomButton(onPressed: sellProduct, text: 'Sell'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
