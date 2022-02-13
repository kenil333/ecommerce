import 'package:ecommerce/modules/generalClasses.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/Buyer/child/updateDetail.dart';

class BasicDetailWidget extends StatelessWidget {
  final Me me;
  final Function func;
  BasicDetailWidget(this.me, this.func);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 25,
        left: 25,
        right: 25,
      ),
      width: double.infinity,
      color: Color(0xFF2874F0),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Account',
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.create_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => UpdateBuyerDetailScreen(func, me),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          me.sex
              ? Image.asset(
                  'assets/images/male.png',
                  height: size.height * 0.15,
                  fit: BoxFit.contain,
                )
              : Image.asset(
                  'assets/images/female.png',
                  height: size.height * 0.15,
                  fit: BoxFit.contain,
                ),
          SizedBox(
            height: 10,
          ),
          Text(
            me.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '+91 ${me.phone}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
