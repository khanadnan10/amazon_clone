import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  String selectedCategoryItem = 'Mobiles';

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
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                DottedBorder(
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
                  controller: priceController,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  hintText: 'Quantity',
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
                CustomButton(onPressed: () {}, text: 'Sell'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
