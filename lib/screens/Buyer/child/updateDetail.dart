import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:ecommerce/widgets/Sellers/Orders/zenderOfDeliveryMan.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Buyer/Profile/maleorfemale.dart';
import 'package:ecommerce/widgets/Buyer/Profile/updateParticular.dart';
import 'package:ecommerce/widgets/Buyer/Profile/updateButton.dart';
import 'package:provider/provider.dart';

class UpdateBuyerDetailScreen extends StatefulWidget {
  final Function func;
  final Me me;
  UpdateBuyerDetailScreen(this.func, this.me);
  @override
  _UpdateBuyerDetailScreenState createState() =>
      _UpdateBuyerDetailScreenState();
}

class _UpdateBuyerDetailScreenState extends State<UpdateBuyerDetailScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  bool _mal = true;
  bool _queryrun = false;

  @override
  void initState() {
    _name.text = widget.me.name;
    _email.text = widget.me.email;
    _address.text = widget.me.address;
    _pincode.text = widget.me.postcode;
    _mal = widget.me.sex;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: CustomizeCode().appBarOfScreens(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MaleOrFemailChanges(),
              ZenderOfDeliveryMan(
                _mal,
                (bool value) {
                  _mal = value;
                  setState(() {});
                },
              ),
              UpdateParticularWidget(
                'Name',
                'Steve Rogers',
                _name,
              ),
              UpdateParticularWidget(
                'Email-ID',
                'SteveRogers@gmail.com',
                _email,
              ),
              UpdateParticularWidget(
                'Address',
                'Ahmedabad, Gujrat, India.',
                _address,
              ),
              UpdateParticularWidget(
                'Pincode',
                '8398',
                _pincode,
              ),
              _queryrun
                  ? Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : UpdateButtonForScreen(
                      () {
                        setState(() {
                          _queryrun = true;
                        });
                        FocusScope.of(context).unfocus();
                        if (_name.text.isEmpty ||
                            _email.text.isEmpty ||
                            _address.text.isEmpty ||
                            _pincode.text.isEmpty) {
                          CustomizeCode().coustomeDiolog(
                            'All Feilds are Mandetory, Please Fill All the Feilds !',
                            context,
                            size,
                          );
                          setState(() {
                            _queryrun = false;
                          });
                        } else {
                          Provider.of<BackCode>(context, listen: false)
                              .updatemedata(
                            widget.me.phone,
                            _name.text.trim(),
                            _email.text.trim(),
                            _address.text.trim(),
                            _pincode.text.trim(),
                            _mal,
                            widget.func,
                            () {
                              setState(() {
                                _queryrun = false;
                                Navigator.of(context).pop();
                              });
                            },
                            (String error) {
                              CustomizeCode().snak(error, context);
                            },
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
