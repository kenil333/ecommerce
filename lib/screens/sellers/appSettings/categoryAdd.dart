import 'dart:io';

import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../customizeCode.dart';

class CategoryAddScreen extends StatefulWidget {
  @override
  _CategoryAddScreenState createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  File _image;
  final ImagePicker picker = ImagePicker();
  bool _queryRun = false;

  void _pickAnImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomizeCode().firstBadgeforMostOFScrren(
                'New Category',
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
                'Category Name',
                _nameController,
              ),
              CustomizeCode().coustomTitlewithTextFeild(
                size,
                'Position',
                _positionController,
              ),
              SizedBox(height: size.height * 0.05),
              _queryRun
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : CustomizeCode().finalBadgeforAddandUpdatedetail(
                      () {
                        setState(() {
                          _queryRun = true;
                        });
                        FocusScope.of(context).unfocus();
                        if (_image == null ||
                            _nameController.text.isEmpty ||
                            _positionController.text.isEmpty) {
                          CustomizeCode().coustomeDiolog(
                            'All Feilds are mendatory, Please Fill All the Feilds !',
                            context,
                            size,
                          );
                          setState(() {
                            _queryRun = false;
                          });
                        } else {
                          Provider.of<BackCode>(context, listen: false)
                              .addcategory(
                            _nameController.text.trim(),
                            _positionController.text.trim(),
                            _image,
                            () {
                              setState(() {
                                _queryRun = false;
                                Navigator.of(context).pop();
                              });
                            },
                            () {
                              CustomizeCode().coustomeDiolog(
                                'This Category Already Excist in the Database !',
                                context,
                                size,
                              );
                              setState(() {
                                _queryRun = false;
                              });
                            },
                            (String error) {
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
