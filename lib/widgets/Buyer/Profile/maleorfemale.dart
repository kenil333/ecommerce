import 'package:flutter/material.dart';

class MaleOrFemailChanges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      color: Color(0xFF2874F0),
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 10),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              width: size.width * 0.2,
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: size.width * 0.07,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: size.width * 0.2),
              width: size.width * 0.8,
              alignment: Alignment.center,
              child: Text(
                'Update Detail',
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
