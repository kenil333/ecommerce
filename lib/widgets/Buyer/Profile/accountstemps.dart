import 'package:flutter/material.dart';

class AccouuntStempsWidget extends StatelessWidget {
  final String title;
  final String value;
  final Function func;
  AccouuntStempsWidget(this.title, this.value, this.func);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: Color(0xFF305F72).withOpacity(0.23),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF305F72),
            ),
          ),
          if (title == 'My Email-Id' || title == 'My Address')
            SizedBox(
              height: 10,
            ),
          if (title == 'My Email-Id' || title == 'My Address')
            Text(
              value,
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFF305F72),
              ),
            ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: func,
              child: Text(
                (title == 'My Email-Id' || title == 'My Address')
                    ? 'Edit'
                    : 'View $title',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
