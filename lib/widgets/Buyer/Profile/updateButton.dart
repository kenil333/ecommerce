import 'package:flutter/material.dart';

class UpdateButtonForScreen extends StatelessWidget {
  final Function func;
  UpdateButtonForScreen(this.func);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30, left: 40, right: 40),
      child: InkWell(
        onTap: () {
          func();
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF3383CD),
                Color(0xFF11249F),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'Update',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 18,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
