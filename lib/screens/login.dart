import 'package:ecommerce/provider/BackCode.dart';
import 'package:ecommerce/screens/registor.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/screens/sellers/tabscreenOfSeller.dart';
import 'package:ecommerce/screens/Buyer/tabbotom.dart';
import 'package:ecommerce/screens/deliveryMan/tabscreenOfDeliveryMan.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _querurun = false;

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      },
    );
    super.initState();
  }

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                _sizedBoxforSpacing(size.height * 0.04),
                CustomizeCode().textfeildandIcon(
                  'Password',
                  Icons.lock_outline,
                  _password,
                ),
                _sizedBoxforSpacing(size.height * 0.02),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => RegisterPhone('Forgot'),
                      ),
                    );
                  },
                  child: Text(
                    'Forgot Password !',
                    style: TextStyle(
                      color: Color(0xFF2D2942),
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
                _sizedBoxforSpacing(size.height * 0.04),
                _querurun
                    ? Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : CustomizeCode().customButtonforLoginAndSignup(
                        size,
                        () {
                          setState(() {
                            _querurun = true;
                          });
                          FocusScope.of(context).unfocus();
                          if (_phone.text.isEmpty || _password.text.isEmpty) {
                            CustomizeCode().coustomeDiolog(
                              'All Feilds are Mandetory, Please Fill All the Feilds !',
                              context,
                              size,
                            );
                            setState(() {
                              _querurun = false;
                            });
                          } else {
                            Provider.of<BackCode>(context, listen: false).login(
                              _phone.text.trim(),
                              _password.text.trim(),
                              (String who) {
                                if (who == 'Customer') {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      settings: RouteSettings(
                                        name: '/CD',
                                      ),
                                      builder: (context) => TabBottomScreen(),
                                    ),
                                  );
                                } else if (who == 'Delivery') {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      settings: RouteSettings(
                                        name: '/DD',
                                      ),
                                      builder: (context) =>
                                          TabBottomScreenOfDeliveryMan(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      settings: RouteSettings(
                                        name: '/SD',
                                      ),
                                      builder: (context) =>
                                          TabBottomScreenOfSeller(),
                                    ),
                                  );
                                }
                              },
                              () {
                                CustomizeCode().coustomeDiolog(
                                  'This Contact Number Not Registered yet !',
                                  context,
                                  size,
                                );
                                setState(() {
                                  _querurun = false;
                                });
                              },
                              () {
                                CustomizeCode().coustomeDiolog(
                                  'Password Must be wrong !',
                                  context,
                                  size,
                                );
                                setState(() {
                                  _querurun = false;
                                });
                              },
                              (String error) {
                                CustomizeCode().snak(error, context);
                              },
                            );
                          }
                        },
                        'Login',
                      ),
                _sizedBoxforSpacing(size.height * 0.04),
                CustomizeCode().indicatorForLoginOrRegistration(
                  'Don\'t have an account ?',
                  context,
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => RegisterPhone('Register'),
                      ),
                    );
                  },
                  'Create account',
                ),
                _sizedBoxforSpacing(size.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
