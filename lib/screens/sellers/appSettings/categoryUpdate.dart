import 'dart:io';

import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../customizeCode.dart';

class CategoryUpdateScreen extends StatefulWidget {
  final Category category;
  CategoryUpdateScreen(this.category);
  @override
  _CategoryUpdateScreenState createState() => _CategoryUpdateScreenState();
}

class _CategoryUpdateScreenState extends State<CategoryUpdateScreen> {
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
  void initState() {
    _nameController.text = widget.category.name;
    _positionController.text = widget.category.position.toString();
    super.initState();
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
                'Update Category',
                size,
                context,
              ),
              _image == null
                  ? CustomizeCode().cacheimage(
                      size,
                      widget.category.image,
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
                        if (_nameController.text.isEmpty ||
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
                          if (_image == null) {
                            Provider.of<BackCode>(context, listen: false)
                                .updatecatewithoutimage(
                              widget.category.id,
                              _nameController.text.trim(),
                              _positionController.text.trim(),
                              () {
                                CustomizeCode().truediload(
                                  'Successfully Updated.',
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
                          } else {
                            Provider.of<BackCode>(context, listen: false)
                                .updatecatewithimage(
                              widget.category.id,
                              _image,
                              _nameController.text.trim(),
                              _positionController.text.trim(),
                              () {
                                CustomizeCode().truediload(
                                  'Successfully Updated.',
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
