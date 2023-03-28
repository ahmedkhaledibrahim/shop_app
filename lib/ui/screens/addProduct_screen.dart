import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:recap/models/productModel.dart';
import 'package:recap/providers/ProductsProviders/ProductRepository.dart';

import 'package:recap/ui/screens/userProducts_screen.dart';
import 'package:recap/ui/widgets/errorsAlertDialog.dart';

import '../widgets/textform_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formkey = GlobalKey<FormState>();
  String radioValue = '';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Text(
                'Add Product Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ModifiedTextFormField(
                  'Title', _titleController, false, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ModifiedTextFormField('Description',
                  _descriptionController, false, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ModifiedTextFormField(
                  'Price', _priceController, false, TextInputType.number),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ModifiedTextFormField(
                  'Image Url', _imageUrlController, false, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text("Clothes"),
              leading: Radio(
                value: 'Clothes',
                groupValue: radioValue,
                onChanged: (value) {
                  setState(() {
                    radioValue = value.toString();
                  });
                },
                activeColor: Color.fromARGB(255, 5, 14, 86),
              ),
            ),
            ListTile(
              title: Text("Sport"),
              leading: Radio(
                value: 'Sport',
                groupValue: radioValue,
                onChanged: (value) {
                  setState(() {
                    radioValue = value.toString();
                  });
                },
                activeColor: Color.fromARGB(255, 5, 14, 86),
              ),
            ),
            ListTile(
              title: Text("Electronics"),
              leading: Radio(
                value: 'Electronics',
                groupValue: radioValue,
                onChanged: (value) {
                  setState(() {
                    radioValue = value.toString();
                  });
                },
                activeColor: Color.fromARGB(255, 5, 14, 86),
              ),
            ),
            ListTile(
              title: Text("Furniture"),
              leading: Radio(
                value: 'Furniture',
                groupValue: radioValue,
                onChanged: (value) {
                  setState(() {
                    radioValue = value.toString();
                  });
                },
                activeColor: Color.fromARGB(255, 5, 14, 86),
              ),
            ),
            Center(
                child: SizedBox(
                    width: 200,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          if (radioValue == '') {
                            showDialog(
                                context: context,
                                builder: (_) => ErrorsAlertDialog(
                                    errorMessage: 'Please Enter Category'));
                          } else {
                            if (_imageUrlController.text.endsWith('.jpg') ||
                                _imageUrlController.text.endsWith('.jpeg') ||
                                _imageUrlController.text.endsWith('.png') ||
                                _imageUrlController.text.contains('http') ||
                                _imageUrlController.text.endsWith('.svg')) {
                              final prod = ProductModel(
                                  category: radioValue,
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  price: double.parse(_priceController.text),
                                  imageUrl: _imageUrlController.text);
                              Provider.of<ProductRepository>(context,
                                      listen: false)
                                  .addProduct(prod);
                              Get.off(() => UserProductsScreen());
                              Get.snackbar(
                                "My Shop",
                                "You Have Added ${_titleController.text} Successfully",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Color.fromARGB(255, 5, 14, 86),
                                icon: Icon(Icons.done, color: Colors.white),
                                borderRadius: 20,
                                margin: EdgeInsets.all(15),
                                colorText: Colors.white,
                                duration: Duration(seconds: 5),
                                isDismissible: true,
                                forwardAnimationCurve: Curves.easeOutBack,
                              );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) => ErrorsAlertDialog(
                                      errorMessage:
                                          'Please Enter Correct Image Url'));
                            }
                          }
                        }
                      },
                      child: Text('Add Product'),
                      backgroundColor: Color.fromARGB(255, 5, 14, 86),
                    )))
          ]),
        ),
      )),
    );
  }
}
