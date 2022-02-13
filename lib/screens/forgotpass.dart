import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customizeCode.dart';

class ForgotPass extends StatefulWidget {
  final String phone;
  ForgotPass(this.phone);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController _pass = TextEditingController();
  TextEditingController _confpass = TextEditingController();
  bool _queryrun = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.07),
              Image.asset(
                'assets/images/logo.png',
                height: size.height * 0.15,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: size.height * 0.07),
              CustomizeCode().textfeildandIcon(
                'Password',
                Icons.lock_outline,
                _pass,
              ),
              SizedBox(height: size.height * 0.03),
              CustomizeCode().textfeildandIcon(
                'Confirm-Password',
                Icons.lock_outline,
                _confpass,
              ),
              SizedBox(height: size.height * 0.1),
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
                        if (_pass.text.isEmpty || _confpass.text.isEmpty) {
                          CustomizeCode().coustomeDiolog(
                            'All Feilds are Mandetory, Please Fill All the Feilds !',
                            context,
                            size,
                          );
                          setState(() {
                            _queryrun = false;
                          });
                        } else {
                          if (_pass.text != _confpass.text) {
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
                                .forgot(
                              widget.phone,
                              _pass.text.trim(),
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
                      'Forgot',
                    ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
