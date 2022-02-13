import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/screens/forgotpass.dart';
import 'package:ecommerce/screens/signUp.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String what;
  OTPScreen(this.phone, this.what);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.04),
              Text(
                'Confimr the Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  color: Color(0xFF305F72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Image.asset(
                'assets/images/logo.png',
                height: size.height * 0.15,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: size.height * 0.07),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.circle,
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    activeColor: Colors.grey,
                    selectedColor: Colors.black,
                    selectedFillColor: Colors.blueGrey[100],
                    inactiveFillColor: Colors.blueGrey[100],
                    inactiveColor: Colors.grey,
                  ),
                  keyboardType: TextInputType.number,
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (pin) {
                    print(pin);
                  },
                  onChanged: (value) {
                    print(value);
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.1),
              CustomizeCode().customButtonforLoginAndSignup(
                size,
                () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  if (widget.what == 'Register') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => SignUpScreen(widget.phone),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ForgotPass(widget.phone),
                      ),
                    );
                  }
                },
                'Confirm',
              ),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
