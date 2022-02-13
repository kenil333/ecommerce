import 'dart:io';

import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductAddScreen extends StatefulWidget {
  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final _key = GlobalKey<ScaffoldState>();
  bool _dataSending = false;
  bool _loading = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionontroller = TextEditingController();
  TextEditingController _id = TextEditingController();
  TextEditingController _deliveryprice = TextEditingController();
  String _category;
  String _productType;
  List<String> _advertisList = [];
  List<String> _cate = [];
  String _advertiseMent;
  File _image;
  final ImagePicker picker = ImagePicker();

  void _pickAnImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (_) async {
        Provider.of<BackCode>(context, listen: false).fetchRequrements(
          'Advertise',
          'Keyword',
          context,
          (value) {
            setState(() {
              _advertisList = value;
            });
          },
        ).then((_) {
          Provider.of<BackCode>(context, listen: false).fetchRequrements(
            'Category',
            'Name',
            context,
            (value) {
              setState(() {
                _cate = value;
              });
            },
          ).then((value) {
            setState(() {
              _loading = false;
            });
          });
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CustomizeCode().firstBadgeforMostOFScrren(
                      'Add New Product',
                      size,
                      context,
                    ),
                    _image == null
                        ? CustomizeCode().addphoto(
                            size,
                            () {
                              _pickAnImage();
                            },
                          )
                        : CustomizeCode().photoAddorEdit(
                            size,
                            _image,
                            () {
                              _pickAnImage();
                            },
                          ),
                    SizedBox(height: size.height * 0.03),
                    CustomizeCode().coustomTitlewithTextFeild(
                      size,
                      'Name',
                      _nameController,
                    ),
                    CustomizeCode().coustomTitlewithTextFeild(
                      size,
                      'Price',
                      _priceController,
                    ),
                    CustomizeCode().coustomTitlewithTextFeild(
                      size,
                      'Delivery-Charge',
                      _deliveryprice,
                    ),
                    CustomizeCode().coustomDropDownWithTitle(
                      size,
                      _category,
                      (value) {
                        setState(() {
                          _category = value;
                        });
                      },
                      'Category',
                      _cate,
                    ),
                    CustomizeCode().coustomDropDownWithTitle(
                      size,
                      _productType,
                      (value) {
                        setState(() {
                          _productType = value;
                        });
                      },
                      'Product Type',
                      [
                        'Recomanded',
                        'On-Sale',
                        'Branded',
                      ],
                    ),
                    CustomizeCode().coustomDropDownWithTitle(
                      size,
                      _advertiseMent,
                      (value) {
                        setState(() {
                          _advertiseMent = value;
                        });
                      },
                      'Advertise Type',
                      _advertisList,
                    ),
                    CustomizeCode().coustomTitlewithTextFeild(
                      size,
                      'Description',
                      _descriptionontroller,
                    ),
                    CustomizeCode().coustomTitlewithTextFeild(
                      size,
                      'Product-ID',
                      _id,
                    ),
                    SizedBox(height: size.height * 0.05),
                    _dataSending
                        ? Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )
                        : CustomizeCode().finalBadgeforAddandUpdatedetail(
                            () {
                              setState(() {
                                _dataSending = true;
                              });
                              FocusScope.of(context).unfocus();
                              if (_image == null ||
                                  _nameController.text.isEmpty ||
                                  _priceController.text.isEmpty ||
                                  _category == null ||
                                  _productType == null ||
                                  _advertiseMent == null ||
                                  _descriptionontroller.text.isEmpty ||
                                  _id.text.isEmpty ||
                                  _deliveryprice.text.isEmpty) {
                                CustomizeCode().coustomeDiolog(
                                  'All Feilds are Mendatory, Including image !',
                                  context,
                                  size,
                                );
                                setState(() {
                                  _dataSending = false;
                                });
                              } else {
                                Provider.of<BackCode>(context, listen: false)
                                    .addproduct(
                                  _id.text.trim(),
                                  _nameController.text.trim(),
                                  _priceController.text.trim(),
                                  _deliveryprice.text.trim(),
                                  _category,
                                  _productType,
                                  _advertiseMent,
                                  _descriptionontroller.text,
                                  _image,
                                  () {
                                    CustomizeCode()
                                        .truediload(
                                      'Products Added Successfully.',
                                      context,
                                      size,
                                    )
                                        .then((_) {
                                      Navigator.of(context).pop();
                                    });
                                    setState(() {
                                      _dataSending = false;
                                    });
                                  },
                                  () {
                                    CustomizeCode().coustomeDiolog(
                                      'This Product-Id Already Exist !',
                                      context,
                                      size,
                                    );
                                    setState(() {
                                      _dataSending = false;
                                    });
                                  },
                                  (error) {
                                    CustomizeCode().snak(error, context);
                                  },
                                );
                              }
                            },
                            size,
                            'Add',
                          ),
                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
      ),
    );
  }
}
