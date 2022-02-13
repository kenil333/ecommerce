import 'package:flutter/material.dart';

class OrderPromptScreen extends StatelessWidget {
  final String nu;
  OrderPromptScreen(this.nu);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil(
          ModalRoute.withName('/CD'),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/abc.gif',
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Your Order Number #$nu is Placed Successfully.',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: Color(0xFF305F72),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).popUntil(
                      ModalRoute.withName('/CD'),
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.015),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3383CD),
                          Color(0xFF11249F),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(15),
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
                      'Order More',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: size.width * 0.055,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
