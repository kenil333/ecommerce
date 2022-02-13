import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../customizeCode.dart';

class ChangePhotoScreen extends StatefulWidget {
  final AdvertiseMent advertise;
  ChangePhotoScreen(this.advertise);
  @override
  _ChangePhotoScreenState createState() => _ChangePhotoScreenState();
}

class _ChangePhotoScreenState extends State<ChangePhotoScreen> {
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
  void initState() {
    _keyWordController.text = widget.advertise.keyword;
    _positionController.text = widget.advertise.position.toString();
    super.initState();
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
                'Update Image',
                size,
                context,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                height: size.height * 0.28,
                child: _image == null
                    ? CachedNetworkImage(
                        imageUrl: widget.advertise.imageURL,
                        placeholder: (context, url) => Container(
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    _pickAnImage();
                  },
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.green,
                    size: size.width * 0.15,
                  ),
                ),
              ),
              CustomizeCode().textFieldWidget(_keyWordController, 'Keyword'),
              CustomizeCode().textFieldWidget(_positionController, 'Position'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: _queryRun
                    ? Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _queryRun = true;
                          });
                          if (_keyWordController.text.isEmpty ||
                              _positionController.text.isEmpty) {
                            CustomizeCode().coustomeDiolog(
                              'Please Enter All Feilds !',
                              context,
                              size,
                            );
                            setState(() {
                              _queryRun = false;
                            });
                          } else {
                            if (_image != null &&
                                _keyWordController.text.isNotEmpty &&
                                _positionController.text.isNotEmpty) {
                              Provider.of<BackCode>(context, listen: false)
                                  .updateAdvertisement(
                                _image,
                                _keyWordController.text,
                                int.parse(_positionController.text),
                                widget.advertise.id,
                                context,
                              )
                                  .then((_) {
                                setState(() {
                                  _queryRun = false;
                                });
                                CustomizeCode().coustomeSnak(
                                  'Updated Successfully',
                                  Colors.green,
                                  context,
                                );
                              });
                            }
                            if (_image == null &&
                                _keyWordController.text.isNotEmpty &&
                                _positionController.text.isNotEmpty) {
                              Provider.of<BackCode>(context, listen: false)
                                  .updateAdwithoutImage(
                                _keyWordController.text,
                                int.parse(_positionController.text),
                                widget.advertise.id,
                                context,
                              )
                                  .then((_) {
                                setState(() {
                                  _queryRun = false;
                                });
                                CustomizeCode().coustomeSnak(
                                  'Updated Successfully',
                                  Colors.green,
                                  context,
                                );
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
                            'Update',
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
