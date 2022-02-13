import 'dart:io';

import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../customizeCode.dart';

class AddNewAdvertiseScreen extends StatefulWidget {
  @override
  _AddNewAdvertiseScreenState createState() => _AddNewAdvertiseScreenState();
}

class _AddNewAdvertiseScreenState extends State<AddNewAdvertiseScreen> {
  TextEditingController _keyWordController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  bool _queryRun = false;
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
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomizeCode().firstBadgeforMostOFScrren(
                'Add Advertise',
                size,
                context,
              ),
              _image == null
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 30,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 20,
                            color: Color(0xFF305F72).withOpacity(0.23),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          _pickAnImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: size.width * 0.2,
                            ),
                            Text(
                              'Choose Image',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: size.width,
                      height: size.height * 0.28,
                      child: Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ),
                    ),
              CustomizeCode().textFieldWidget(_keyWordController, 'Keyword'),
              CustomizeCode().textFieldWidget(_positionController, 'Position'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                child: _queryRun
                    ? Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            _queryRun = true;
                          });
                          FocusScope.of(context).unfocus();
                          if (_image == null) {
                            CustomizeCode().coustomeDiolog(
                              'Please Choose an Image for Advertisement !',
                              context,
                              size,
                            );
                            setState(() {
                              _queryRun = false;
                            });
                          } else {
                            if (_keyWordController.text.isEmpty ||
                                _positionController.text.isEmpty) {
                              CustomizeCode().coustomeDiolog(
                                'All Feilds are Mandetory, Please Fill All the Fields !',
                                context,
                                size,
                              );
                              setState(() {
                                _queryRun = false;
                              });
                            } else {
                              Provider.of<BackCode>(context, listen: false)
                                  .addAdvertise(
                                _image,
                                _keyWordController.text.trim(),
                                int.parse(_positionController.text.trim()),
                                context,
                              )
                                  .then((value) {
                                setState(() {
                                  _queryRun = false;
                                });
                                Navigator.of(context).pop();
                              });
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF3383CD),
                                Color(0xFF11249F),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 20,
                                color: Color(0xFF305F72).withOpacity(0.3),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
