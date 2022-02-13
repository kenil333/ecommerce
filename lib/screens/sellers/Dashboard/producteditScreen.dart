import 'dart:io';

import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductEditScreen extends StatefulWidget {
  final Products iteams;
  ProductEditScreen(this.iteams);
  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  bool _loading = true;
  bool _dataSending = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionontroller = TextEditingController();
  TextEditingController _id = TextEditingController();
  TextEditingController _deliveryprice = TextEditingController();
  List<String> _cate = [];
  String _category;
  String _productType;
  List<String> _advertisList;
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
            _nameController.text = widget.iteams.name;
            _priceController.text = widget.iteams.price.toStringAsFixed(2);
            _deliveryprice.text = widget.iteams.dcharge.toStringAsFixed(2);
            _category = widget.iteams.category;
            _productType = widget.iteams.ptype;
            _advertiseMent = widget.iteams.atype;
            _descriptionontroller.text = widget.iteams.description;
            _id.text = widget.iteams.id;
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                      'Update Product',
                      size,
                      context,
                    ),
                    _image == null
                        ? CustomizeCode().cacheimage(
                            size,
                            widget.iteams.image,
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
                    CustomizeCode().disabletextfeild(
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
                            () async {
                              setState(() {
                                _dataSending = true;
                              });
                              FocusScope.of(context).unfocus();
                              if (_nameController.text.isEmpty ||
                                  _priceController.text.isEmpty ||
                                  _category == null ||
                                  _productType == null ||
                                  _advertiseMent == null ||
                                  _descriptionontroller.text.isEmpty ||
                                  _deliveryprice.text.isEmpty) {
                                CustomizeCode().coustomeDiolog(
                                  'All Feilds are Mandatory, Please All Feild !',
                                  context,
                                  size,
                                );
                              } else {
                                if (_image == null) {
                                  Provider.of<BackCode>(context, listen: false)
                                      .updateproduct(
                                    widget.iteams.id,
                                    _nameController.text.trim(),
                                    widget.iteams.image,
                                    _priceController.text.trim(),
                                    _deliveryprice.text.trim(),
                                    _category,
                                    _productType,
                                    _advertiseMent,
                                    _descriptionontroller.text,
                                    () {
                                      CustomizeCode().truediload(
                                        'Products Updated Successfully.',
                                        context,
                                        size,
                                      );
                                      setState(() {
                                        _dataSending = false;
                                      });
                                    },
                                    (String error) {
                                      CustomizeCode().snak(error, context);
                                    },
                                  );
                                } else {
                                  String _url = '';
                                  await Provider.of<BackCode>(context,
                                          listen: false)
                                      .uploadandget(
                                    'Product',
                                    widget.iteams.id,
                                    _image,
                                    (String url) {
                                      _url = url;
                                    },
                                    (String error) {
                                      CustomizeCode().snak(error, context);
                                    },
                                  ).then((_) {
                                    Provider.of<BackCode>(context,
                                            listen: false)
                                        .updateproduct(
                                      widget.iteams.id,
                                      _nameController.text.trim(),
                                      _url,
                                      _priceController.text.trim(),
                                      _deliveryprice.text.trim(),
                                      _category,
                                      _productType,
                                      _advertiseMent,
                                      _descriptionontroller.text,
                                      () {
                                        CustomizeCode().truediload(
                                          'Products Updated Successfully.',
                                          context,
                                          size,
                                        );
                                        setState(() {
                                          _dataSending = false;
                                        });
                                      },
                                      (String error) {
                                        CustomizeCode().snak(error, context);
                                      },
                                    );
                                  });
                                }
                              }
                            },
                            size,
                            'Update',
                          ),
                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
      ),
    );
  }
}
