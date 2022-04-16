// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:shop_manager/config/colors.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:shop_manager/models/GeneralProvider.dart';
import 'package:shop_manager/models/ShopModel.dart';
import 'package:shop_manager/pages/productlist.dart';

class AddProductScreen extends StatefulWidget {
  // final Product product;
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final productName = TextEditingController();
  final productPrice = TextEditingController();
  final productCategory = TextEditingController();
  final productQuantity = TextEditingController();
  File? _image;

  String? _selectedCategory;
  List<String?> cat = [];
  //String imagePath;
  final picker = ImagePicker();

  int categoryIndex = 0;

  Future _imgFromCamera() async {
    final image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    try {
      setState(() {
        _image = File(image!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  _imgFromGallery() async {
    final image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 80);
    try {
      setState(() {
        _image = File(image!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  _removeimage() {
    setState(() {
      _image = null;
    });
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () {
          Product product = Product(
            productName: productName.text,
            sellingPrice:
                double.tryParse(productPrice.text.replaceRange(0, 3, "")),
            quantity: int.tryParse(productQuantity.text),
            costPrice: double.tryParse(productPrice.text),
          );

          Provider.of<GeneralProvider>(context, listen: false)
              .categories![categoryIndex]
              .products!
              .add(product);

          // Provider.of<GeneralProvider>(context, listen: false)
          //     .inventory
          //     .add(product);

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ProductListScreen(
          //               categoryIndex: categoryIndex,
          //             )));
          Navigator.pop(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              //border: Border.all(color: BaseColors.secondaryColor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black45,
                    offset: Offset(1, 3),
                    blurRadius: 5,
                    spreadRadius: 1)
              ],
              color: ShopColors.primaryColor),
          child: Text(
            'Done',
            style: TextStyle(fontSize: 20, color: ShopColors.secondaryColor),
          ),
        ));
  }

  Widget _uploadButton() {
    return InkWell(
        onTap: () {
          _imgFromGallery();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .4,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              //border: Border.all(color: BaseColors.secondaryColor, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black45,
                    offset: Offset(1, 3),
                    blurRadius: 5,
                    spreadRadius: 1)
              ],
              color: ShopColors.primaryColor),
          child: Text(
            'Upload image',
            style: TextStyle(fontSize: 20, color: ShopColors.secondaryColor),
          ),
        ));
  }

  Widget _takeButton() {
    return InkWell(
        onTap: () {
          _imgFromCamera();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: ShopColors.primaryColor, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: ShopColors.secondaryColor),
          child: Text(
            'Take photo',
            style: TextStyle(
                fontSize: 20,
                color: ShopColors.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  @override
  void initState() {
    for (var item
        in Provider.of<GeneralProvider>(context, listen: false).categories!) {
      cat.add(item.categoryName);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ShopColors.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Text("Let's add the products in your shop",
                    style:
                        TextStyle(color: ShopColors.textColor, fontSize: 25)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ShopColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: productName,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: ShopColors.primaryColor,
                      fontSize: 17,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.add_box,
                          color: ShopColors.primaryColor, size: 20),
                      hintText: "Product name",
                      hintStyle: TextStyle(color: ShopColors.primaryColor),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorStyle: TextStyle(fontSize: 15),
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
                    ),
                    // validator: MultiValidator([
                    //   RequiredValidator(
                    //       errorText: "*field cannot be empty"),
                    // ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 2,
                          style: BorderStyle.solid,
                          color: ShopColors.primaryColor)),
                  child: TextField(
                    controller: productPrice,
                    //textAlign: TextAlign.center,

                    keyboardType: TextInputType.number,
                    style: TextStyle(color: ShopColors.textColor, fontSize: 15),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.money,
                            color: ShopColors.primaryColor, size: 20),
                        hintText: "GHS 00.00",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: ShopColors.primaryColor, fontSize: 15)),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                          turnOffGrouping: true,
                          decimalDigits: 2,
                          // locale: 'usa',
                          symbol: 'GHS '),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ShopColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.black87),
                        border: InputBorder.none,
                        enabled: false,
                        fillColor: Colors.transparent,
                        filled: true),
                    hint: Text('Select Category'),
                    value: _selectedCategory,
                    onChanged: (dynamic newValue) {
                      setState(() {
                        categoryIndex = cat.indexOf(newValue);
                      });
                    },
                    items: cat.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location!),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: 50,
              //     decoration: BoxDecoration(
              //         border:
              //             Border.all(color: ShopColors.primaryColor, width: 2),
              //         borderRadius: BorderRadius.circular(20)),
              //     child: TextFormField(
              //       controller: productCategory,
              //       textAlign: TextAlign.justify,
              //       style: TextStyle(
              //         color: ShopColors.primaryColor,
              //         fontSize: 17,
              //       ),
              //       decoration: InputDecoration(
              //         prefixIcon: Icon(Icons.category,
              //             color: ShopColors.primaryColor, size: 20),
              //         hintText: "Category",
              //         hintStyle: TextStyle(color: ShopColors.primaryColor),
              //         border: InputBorder.none,
              //         focusedBorder: InputBorder.none,
              //         enabledBorder: InputBorder.none,
              //         errorStyle: TextStyle(fontSize: 15),
              //         disabledBorder: InputBorder.none,
              //         isDense: true,
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
              //       ),
              //       // validator: MultiValidator([
              //       //   RequiredValidator(
              //       //       errorText: "*field cannot be empty"),
              //       // ]),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ShopColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: productQuantity,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: ShopColors.primaryColor,
                      fontSize: 17,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.category,
                          color: ShopColors.primaryColor, size: 20),
                      hintText: "Quantity",
                      hintStyle: TextStyle(color: ShopColors.primaryColor),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorStyle: TextStyle(fontSize: 15),
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
                    ),
                    // validator: MultiValidator([
                    //   RequiredValidator(
                    //       errorText: "*field cannot be empty"),
                    // ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _uploadButton(),
                        SizedBox(height: 20),
                        _takeButton()
                      ],
                    ),
                    Container(
                      width: width * 0.45,
                      height: height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ShopColors.primaryColor),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                _image!,
                                width: width * 0.45,
                                height: height * 0.25,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                //color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: width * 0.45,
                              height: height * 0.25,
                              child: Icon(
                                Icons.camera_alt,
                                color: ShopColors.secondaryColor,
                                size: 30,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: _submitButton(),
              ),
            ],
          ),
        )),
      ),
    );
  }
}