import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  final String phone;
  SignUpScreen(this.phone);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _emailId = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _pincode = TextEditingController();
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
              _sizedBoxforSpacing(size.height * 0.01),
              Container(
                padding: EdgeInsets.only(left: 15),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: size.width * 0.07,
                        color: Color(0xFF305F72),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Create a New Account',
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Color(0xFF305F72),
                      ),
                    ),
                  ],
                ),
              ),
              _sizedBoxforSpacing(size.height * 0.05),
              CustomizeCode().textfeildandIcon(
                'Name',
                Icons.person_outline,
                _name,
              ),
              _sizedBoxforSpacing(size.height * 0.03),
              CustomizeCode().textfeildandIcon(
                'Email-ID',
                Icons.email_outlined,
                _emailId,
              ),
              _sizedBoxforSpacing(size.height * 0.03),
              CustomizeCode().textfeildandIcon(
                'Password',
                Icons.lock_outline,
                _password,
              ),
              _sizedBoxforSpacing(size.height * 0.03),
              CustomizeCode().textfeildandIcon(
                'Confirm-Password',
                Icons.lock_outline,
                _confirmPassword,
              ),
              _sizedBoxforSpacing(size.height * 0.03),
              CustomizeCode().textfeildandIcon(
                'Address',
                Icons.post_add,
                _address,
              ),
              _sizedBoxforSpacing(size.height * 0.03),
              CustomizeCode().textfeildandIcon(
                'Pincode',
                Icons.pin_drop,
                _pincode,
              ),
              _sizedBoxforSpacing(size.height * 0.06),
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
                        if (_name.text.isEmpty ||
                            _emailId.text.isEmpty ||
                            _password.text.isEmpty ||
                            _confirmPassword.text.isEmpty ||
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
                          if (_password.text != _confirmPassword.text) {
                            CustomizeCode().coustomeDiolog(
                              'Please Enter the Same Password in both the Password Feild !',
                              context,
                              size,
                            );
                            setState(() {
                              _queryrun = false;
                            });
                          } else {
                            Provider.of<BackCode>(context, listen: false)
                                .register(
                              widget.phone,
                              _name.text.trim(),
                              _emailId.text.trim(),
                              _password.text.trim(),
                              _address.text,
                              _pincode.text.trim(),
                              () {
                                setState(() {
                                  _queryrun = false;
                                });
                                Navigator.of(context).pop();
                              },
                              (String error) {
                                CustomizeCode().snak(error, context);
                              },
                            );
                          }
                        }
                      },
                      'Create',
                    ),
              _sizedBoxforSpacing(size.height * 0.04),
              CustomizeCode().indicatorForLoginOrRegistration(
                'Already have an account ?',
                context,
                () {
                  Navigator.of(context).pop();
                },
                'Login',
              ),
              _sizedBoxforSpacing(size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
