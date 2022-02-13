import 'package:ecommerce/customizeCode.dart';
import 'package:ecommerce/provider/BackCode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PAckingConfirmWidget extends StatelessWidget {
  final String id;
  PAckingConfirmWidget(this.id);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void _updatedetail() {
      Provider.of<BackCode>(context, listen: false).changestatus(
        id,
        () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        (String error) {
          CustomizeCode().snak(error, context);
        },
      );
    }

    _buttonsOfthisScreen(String title, Function func) {
      return Container(
        //width: size.width * 0.7,
        //height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
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
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onPressed: func,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 1.5,
            ),
          ),
          textColor: Color(0xFFFFFFFF),
        ),
      );
    }

    return Container(
      height: size.height * 0.3,
      width: size.width,
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
        children: [
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 10),
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
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.03,
                    bottom: size.height * 0.04,
                  ),
                  width: size.width,
                  alignment: Alignment.center,
                  child: Text(
                    'Are You Sure ?',
                    style: TextStyle(
                      fontSize: size.height * 0.03,
                      color: Color(0xFF305F72),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buttonsOfthisScreen('No', () {
                      Navigator.of(context).pop();
                    }),
                    _buttonsOfthisScreen('Yes', () {
                      _updatedetail();
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
