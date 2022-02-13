import 'package:flutter/material.dart';

class UpdateParticularWidget extends StatelessWidget {
  final String title;
  final String value;
  final TextEditingController control;
  UpdateParticularWidget(
    this.title,
    this.value,
    this.control,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF305F72),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextField(
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
            ),
          ),
        ],
      ),
    );
  }
}
