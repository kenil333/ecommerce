import 'package:ecommerce/modules/generalClasses.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/widgets/Sellers/Orders/zenderOfDeliveryMan.dart';
import 'package:provider/provider.dart';

class DeliveryManProfileInSeller extends StatefulWidget {
  final DeliveryMan mann;
  DeliveryManProfileInSeller(this.mann);
  @override
  _DeliveryManProfileInSellerState createState() =>
      _DeliveryManProfileInSellerState();
}

class _DeliveryManProfileInSellerState
    extends State<DeliveryManProfileInSeller> {
  DeliveryMan del;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _tot = TextEditingController();

  @override
  void initState() {
    del = DeliveryMan(
      phone: widget.mann.phone,
      name: widget.mann.name,
      email: widget.mann.email,
      address: widget.mann.address,
      pincode: widget.mann.pincode,
      mal: widget.mann.mal,
    );
    _name.text = widget.mann.name;
    _email.text = widget.mann.email;
    _address.text = widget.mann.address;
    _pincode.text = widget.mann.pincode;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final api = FirebaseDatabase.instance
        .reference()
        .child('Order')
        .orderByChild('DeliveryMan')
        .equalTo(widget.mann.phone)
        .onValue;

    _bottomsheetOfthisScrren(
      String title,
      String work,
      String value,
      Function func,
      TextEditingController control,
    ) {
      return Container(
        width: size.width,
        height: size.height * 0.35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF305F72),
              blurRadius: 25,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                width: size.width * 0.5,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 30),
              child: Text(
                '$work $title',
                style: TextStyle(
                  color: Color(0xFF305F72),
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    color: Color(0xFF305F72).withOpacity(0.23),
                  ),
                ],
              ),
              child: TextField(
                controller: control,
                keyboardType: title == 'Pincode'
                    ? TextInputType.number
                    : TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF305F72),
                ),
                decoration: InputDecoration(
                  hintText: value,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              width: size.width,
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  InkWell(
                    onTap: () {
                      func();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
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
                        '$work',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: size.width * 0.055,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _detailofDeliveryMan(
      BuildContext context,
      String title,
      String value,
      Function func,
      TextEditingController control,
    ) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 20,
              color: Color(0xFF305F72).withOpacity(0.23),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF305F72),
              ),
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: title == 'Total Deliveries' || title == 'Phone-Number'
                    ? 20
                    : 17,
                color: Color(0xFF305F72),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            title == 'Total Deliveries' || title == 'Phone-Number'
                ? SizedBox()
                : Divider(
                    color: Colors.grey,
                  ),
            title == 'Total Deliveries' || title == 'Phone-Number'
                ? SizedBox()
                : SizedBox(
                    height: 10,
                  ),
            title == 'Total Deliveries' || title == 'Phone-Number'
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.only(right: 10),
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: Builder(
                      builder: (context) => InkWell(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) => _bottomsheetOfthisScrren(
                              title,
                              'Update',
                              value,
                              func,
                              control,
                            ),
                          );
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                          ),
                        ),
                      ),
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
                'Profile',
                size,
                context,
              ),
              ZenderOfDeliveryMan(
                del.mal,
                (bool value) {
                  Provider.of<BackCode>(context, listen: false).editdetaildel(
                    widget.mann.phone,
                    'Sex',
                    value,
                    () {
                      del.mal = value;
                      setState(() {});
                    },
                    (String error) {
                      CustomizeCode().snak(error, context);
                    },
                  );
                },
              ),
              _detailofDeliveryMan(
                context,
                'Phone-Number',
                '+91 ${del.phone}',
                () {},
                _phone,
              ),
              _detailofDeliveryMan(
                context,
                'Name',
                del.name,
                () {
                  if (_name.text.isEmpty) {
                    CustomizeCode().coustomeDiolog(
                        'Please Fill This Feild !', context, size);
                  } else {
                    Provider.of<BackCode>(context, listen: false).editdetaildel(
                      widget.mann.phone,
                      'Name',
                      _name.text.trim(),
                      () {
                        del.name = _name.text.trim();
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      (String error) {
                        CustomizeCode().snak(error, context);
                      },
                    );
                  }
                },
                _name,
              ),
              _detailofDeliveryMan(
                context,
                'Email-Id',
                del.email,
                () {
                  if (_email.text.isEmpty) {
                    CustomizeCode().coustomeDiolog(
                        'Please Fill This Feild !', context, size);
                  } else {
                    Provider.of<BackCode>(context, listen: false).editdetaildel(
                      widget.mann.phone,
                      'Email',
                      _email.text.trim(),
                      () {
                        del.email = _email.text.trim();
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      (String error) {
                        CustomizeCode().snak(error, context);
                      },
                    );
                  }
                },
                _email,
              ),
              _detailofDeliveryMan(
                context,
                'Address',
                del.address,
                () {
                  if (_address.text.isEmpty) {
                    CustomizeCode().coustomeDiolog(
                        'Please Fill This Feild !', context, size);
                  } else {
                    Provider.of<BackCode>(context, listen: false).editdetaildel(
                      widget.mann.phone,
                      'Address',
                      _address.text.trim(),
                      () {
                        del.address = _address.text.trim();
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      (String error) {
                        CustomizeCode().snak(error, context);
                      },
                    );
                  }
                },
                _address,
              ),
              _detailofDeliveryMan(
                context,
                'Pincode',
                del.pincode,
                () {
                  if (_pincode.text.isEmpty) {
                    CustomizeCode().coustomeDiolog(
                        'Please Fill This Feild !', context, size);
                  } else {
                    Provider.of<BackCode>(context, listen: false).editdetaildel(
                      widget.mann.phone,
                      'Pincode',
                      _pincode.text.trim(),
                      () {
                        del.pincode = _pincode.text.trim();
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      (String error) {
                        CustomizeCode().snak(error, context);
                      },
                    );
                  }
                },
                _pincode,
              ),
              StreamBuilder(
                  stream: api,
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snap.hasData &&
                          !snap.hasError &&
                          snap.data.snapshot.value != null) {
                        List<String> _ids = [];
                        snap.data.snapshot.value.forEach((key, value) {
                          _ids.add(key);
                        });
                        return _detailofDeliveryMan(
                          context,
                          'Total Deliveries',
                          _ids.length.toString(),
                          () {},
                          _tot,
                        );
                      } else {
                        return _detailofDeliveryMan(
                          context,
                          'Total Deliveries',
                          '0',
                          () {},
                          _tot,
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
