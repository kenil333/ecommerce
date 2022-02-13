import 'package:flutter/material.dart';

class ZenderOfDeliveryMan extends StatelessWidget {
  final bool mal;
  final Function func;
  ZenderOfDeliveryMan(this.mal, this.func);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 50, top: 10),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              func(true);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              width: size.width * 0.3,
              height: size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: mal ? Colors.blue : Colors.transparent,
              ),
              child: Image.asset(
                'assets/images/male.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Or',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF305F72),
            ),
          ),
          InkWell(
            onTap: () {
              func(false);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              width: size.width * 0.3,
              height: size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: mal ? Colors.transparent : Colors.blue,
              ),
              child: Image.asset(
                'assets/images/female.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
