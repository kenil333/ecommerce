import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Sellers/Orders/zenderOfDeliveryMan.dart';
import 'package:provider/provider.dart';

class AddDeliveryManScreen extends StatefulWidget {
  @override
  _AddDeliveryManScreenState createState() => _AddDeliveryManScreenState();
}

class _AddDeliveryManScreenState extends State<AddDeliveryManScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  bool _mal = true;
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _textFeildForDetail(
      String title,
      TextEditingController control,
    ) {
      return Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF305F72),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: control,
              keyboardType: title == 'Phone-Number' || title == 'Pincode'
                  ? TextInputType.number
                  : TextInputType.emailAddress,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF305F72),
              ),
              decoration: InputDecoration(
                hintText: title,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomizeCode().firstBadgeforMostOFScrren(
                'Add Detail',
                size,
                context,
              ),
              ZenderOfDeliveryMan(
                _mal,
                (bool value) {
                  _mal = value;
                  setState(() {});
                },
              ),
              _textFeildForDetail('Name', _name),
              _textFeildForDetail('Phone-Number', _phone),
              _textFeildForDetail('Email-Id', _email),
              _textFeildForDetail('Address', _address),
              _textFeildForDetail('Pincode', _pincode),
              SizedBox(height: 10),
              _queryrun
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : CustomizeCode().finalBadgeforAddandUpdatedetail(
                      () {
                        setState(() {
                          _queryrun = true;
                        });
                        FocusScope.of(context).unfocus();
                        if (_name.text.isEmpty ||
                            _phone.text.isEmpty ||
                            _email.text.isEmpty ||
                            _address.text.isEmpty ||
                            _pincode.text.isEmpty) {
                          CustomizeCode().coustomeDiolog(
                            'All Feilds are Mandetory, Please Fill all the Feilds !',
                            context,
                            size,
                          );
                          setState(() {
                            _queryrun = false;
                          });
                        } else {
                          Provider.of<BackCode>(context, listen: false)
                              .adddeliveryman(
                            _phone.text.trim(),
                            _name.text.trim(),
                            _email.text.trim(),
                            _address.text.trim(),
                            _pincode.text.trim(),
                            _mal,
                            () {
                              setState(() {
                                _queryrun = false;
                                Navigator.of(context).pop();
                              });
                            },
                            () {
                              CustomizeCode().coustomeDiolog(
                                'This Phone Number is Already in Used !',
                                context,
                                size,
                              );
                              setState(() {
                                _queryrun = false;
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
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
