import 'package:ecommerce/provider/BackCode.dart';
import 'package:ecommerce/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customizeCode.dart';

class RegisterPhone extends StatefulWidget {
  final String what;
  RegisterPhone(this.what);
  @override
  _RegisterPhoneState createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  TextEditingController _phone = TextEditingController();
  bool _queryrun = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _sizedBoxforSpacing(double space) {
      return SizedBox(
        height: space,
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _sizedBoxforSpacing(size.height * 0.04),
              Text(
                widget.what == 'Register'
                    ? 'Register the Contact Number'
                    : 'Forgot Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  color: Color(0xFF305F72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              _sizedBoxforSpacing(size.height * 0.04),
              Image.asset(
                'assets/images/logo.png',
                height: size.height * 0.15,
                fit: BoxFit.fitHeight,
              ),
              _sizedBoxforSpacing(size.height * 0.07),
              CustomizeCode().textfeildandIcon(
                'Contact Number',
                Icons.phone,
                _phone,
              ),
              _sizedBoxforSpacing(size.height * 0.1),
              _queryrun
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : CustomizeCode().customButtonforLoginAndSignup(
                      size,
                      () {
                        setState(() {
                          _queryrun = true;
                        });
                        FocusScope.of(context).unfocus();
                        if (_phone.text.isEmpty) {
                          CustomizeCode().coustomeDiolog(
                            'All Feilds are Mandetory, Please Fill All the Feilds !',
                            context,
                            size,
                          );
                          setState(() {
                            _queryrun = false;
                          });
                        } else {
                          if (widget.what == 'Register') {
                            Provider.of<BackCode>(context, listen: false)
                                .allowregister(
                              _phone.text.trim(),
                              () {
                                setState(() {
                                  _queryrun = false;
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => OTPScreen(
                                      _phone.text.trim(),
                                      widget.what,
                                    ),
                                  ),
                                );
                              },
                              () {
                                CustomizeCode().coustomeDiolog(
                                  'This Contact Number is Already in Use !',
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
                          } else {
                            Provider.of<BackCode>(context, listen: false)
                                .allowtoforgot(
                              _phone.text.trim(),
                              () {
                                setState(() {
                                  _queryrun = false;
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => OTPScreen(
                                      _phone.text.trim(),
                                      widget.what,
                                    ),
                                  ),
                                );
                              },
                              () {
                                CustomizeCode().coustomeDiolog(
                                  'This Contact Number is Already in Use !',
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
                        }
                      },
                      widget.what == 'Register' ? 'Register' : 'Confirm',
                    ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
